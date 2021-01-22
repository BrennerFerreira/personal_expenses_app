import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
import 'package:personal_expenses/models/visibility_filter.dart';
import 'package:personal_expenses/screens/common/update_home_screen.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';
import 'package:personal_expenses/screens/future_transactions_screen/widgets/future_transactions_balance_card.dart';

class FutureTransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                vertical: MediaQuery.of(context).size.width * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Transações futuras",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.width * 0.025,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocBuilder<FutureTransactionsStatsBloc,
                              FutureTransactionsStatsState>(
                            builder: (context, state) {
                              BlocProvider.of<FutureTransactionsStatsBloc>(
                                      context)
                                  .add(
                                const FutureTransactionsStatsUpdated(),
                              );
                              if (state
                                  is FutureTransactionsStatsLoadInProgress) {
                                return SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state
                                  is FutureTransactionsStatsLoadSuccess) {
                                return FutureTransactionsBalanceCard(
                                  totalIncome: state.totalIncome,
                                  totalOutcome: state.totalOutcome,
                                  highestIncome: state.higherIncome,
                                  highestOutcome: state.higherOutcome,
                                );
                              } else {
                                return const SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Text(
                                    "Erro aos calcular os dados. Por favor, reinicie o aplicativo",
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                            },
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              "Transações agendadas:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          BlocBuilder<FilteredTransactionsBloc,
                                  FilteredTransactionsState>(
                              builder: (context, state) {
                            BlocProvider.of<FilteredTransactionsBloc>(context)
                                .add(
                              const FilterUpdated(
                                VisibilityFilter.future,
                              ),
                            );
                            if (state is FilteredTransactionsLoadInProgress) {
                              return Flexible(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            } else if (state
                                is FilteredTransactionsLoadSuccess) {
                              if (state.filteredTransactions.isEmpty) {
                                return const Flexible(
                                  child: Center(
                                    child: Text("Não há transações agendadas."),
                                  ),
                                );
                              } else {
                                return Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        state.filteredTransactions.length,
                                    itemBuilder: (_, index) {
                                      return UserTransactionTile(
                                        transaction:
                                            state.filteredTransactions[index],
                                        onWillPopDetails: () async {
                                          BlocProvider.of<
                                                      FilteredTransactionsBloc>(
                                                  context)
                                              .add(
                                            const FilterUpdated(
                                              VisibilityFilter.future,
                                            ),
                                          );
                                          BlocProvider.of<
                                                      FutureTransactionsStatsBloc>(
                                                  context)
                                              .add(
                                            const FutureTransactionsStatsUpdated(),
                                          );
                                          return true;
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                            } else {
                              return const Expanded(
                                child: Center(
                                  child:
                                      Text("Erro ao carregar as transações."),
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
