import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/screens/common/update_home_screen.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';
import 'package:personal_expenses/screens/monthly_analysis_screen/widgets/date_range_balance_card.dart';
import 'package:personal_expenses/screens/monthly_analysis_screen/widgets/date_range_selector.dart';

class MonthlyAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime _startDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
    );
    DateTime _endDate = DateTime(
      DateTime.now().year,
      DateTime.now().month + 1,
      0,
    );
    return WillPopScope(
      onWillPop: () async {
        UpdateHomeScreen().updateHome(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.025,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.015,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const Text(
                      "Análise por período",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: DateRangeSelector(
                      changeDateRange: (newRange) {
                        _startDate = newRange.start;
                        _endDate = newRange.end;
                        BlocProvider.of<DateRangeFilteredTransactionsBloc>(
                          context,
                          listen: false,
                        ).add(
                          DateRangeFilterUpdate(
                            dateRange: DateTimeRange(
                              start: newRange.start,
                              end: newRange.end,
                            ),
                          ),
                        );
                        BlocProvider.of<DateRangeStatsBloc>(context).add(
                          DateRangeStatsUpdated(
                            DateTimeRange(
                              start: newRange.start,
                              end: newRange.end,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.width * 0.015,
                        ),
                        child: ListView(
                          primary: true,
                          shrinkWrap: true,
                          children: [
                            BlocBuilder<DateRangeStatsBloc,
                                DateRangeStatsState>(
                              builder: (context, state) {
                                if (state is DateRangeStatsLoadInProgress) {
                                  return SizedBox(
                                    height: 250,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (state is DateRangeStatsLoadSuccess) {
                                  return DateRangeBalanceCard(
                                    totalIncome: state.totalIncome,
                                    totalOutcome: state.totalOutcome,
                                    highestIncome: state.highestIncome,
                                    highestOutcome: state.highestOutcome,
                                  );
                                } else {
                                  return const SizedBox(
                                    height: 250,
                                    child: Center(
                                        child: Text(
                                            "Erro ao calcular as estatísticas. Reinicie o aplicativo e tente novamente.")),
                                  );
                                }
                              },
                            ),
                            const Text(
                              "Transações no período:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            BlocBuilder<DateRangeFilteredTransactionsBloc,
                                    DateRangeFilteredTransactionsState>(
                                builder: (context, state) {
                              if (state
                                  is DateRangeFilteredTransactionsLoadInProgress) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                );
                              } else if (state
                                  is DateRangeFilteredTransactionsLoadSuccess) {
                                return ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: state.transactionList.length,
                                  itemBuilder: (_, index) {
                                    return UserTransactionTile(
                                      transaction: state.transactionList[index],
                                      onWillPopDetails: () async {
                                        BlocProvider.of<
                                            DateRangeFilteredTransactionsBloc>(
                                          context,
                                          listen: false,
                                        ).add(
                                          DateRangeFilterUpdate(
                                            dateRange: DateTimeRange(
                                              start: _startDate,
                                              end: _endDate,
                                            ),
                                          ),
                                        );
                                        BlocProvider.of<DateRangeStatsBloc>(
                                                context)
                                            .add(
                                          DateRangeStatsUpdated(
                                            DateTimeRange(
                                              start: _startDate,
                                              end: _endDate,
                                            ),
                                          ),
                                        );
                                        return true;
                                      },
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    "Erro ao carregar as transações. Por favor, reinicie o aplicativo e tente novamente.",
                                  ),
                                );
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
