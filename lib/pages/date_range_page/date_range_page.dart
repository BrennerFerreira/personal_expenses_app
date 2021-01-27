import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/date_range_page/date_range_page_bloc.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/date_range_page/widgets/date_range_balance_card.dart';
import 'package:personal_expenses/pages/home_page/home_page.dart';
import 'package:personal_expenses/pages/date_range_page/widgets/date_range_selector.dart';
import 'package:personal_expenses/pages/transaction_details_page/transaction_detail_page.dart';

class DateRangePage extends StatefulWidget {
  @override
  _DateRangePageState createState() => _DateRangePageState();
}

class _DateRangePageState extends State<DateRangePage> {
  late DateRangePageBloc dateRangePageBloc;

  @override
  void initState() {
    super.initState();
    dateRangePageBloc = DateRangePageBloc()
      ..add(
        UpdateDateRangePage(
          startDate: DateTime(
            DateTime.now().year,
            DateTime.now().month,
          ),
          endDate: DateTime(
            DateTime.now().year,
            DateTime.now().month + 1,
            0,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DateRangePageBloc>(
      create: (context) => dateRangePageBloc,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
              (route) => false);
          return true;
        },
        child: CommonScaffold(
          title: "Análise por Período",
          leadingButton: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                  (route) => false);
            },
          ),
          children: [
            DateRangeSelector(
              dateRangePageBloc: dateRangePageBloc,
            ),
            BlocBuilder<DateRangePageBloc, DateRangePageState>(
              builder: (context, state) {
                if (state is DateRangePageLoadInProgress) {
                  return CommonCircularIndicator();
                } else if (state is DateRangePageLoadSuccess) {
                  return Expanded(
                    child: BlurredCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          DateRangeBalanceCard(
                            totalIncome: state.income,
                            totalOutcome: state.outcome,
                            highestIncome: state.highestIncome,
                            highestOutcome: state.highestOutcome,
                          ),
                          if (state.transactionList.isNotEmpty)
                            const Text(
                              "Transações no período:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          Expanded(
                            child: state.transactionList.isEmpty
                                ? const Center(
                                    child: Text(
                                      "Não há transações para o período selecionado.",
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.transactionList.length,
                                    itemBuilder: (_, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  TransactionDetailsPage(
                                                transaction: state
                                                    .transactionList[index],
                                                lastPage: MaterialPageRoute(
                                                  builder: (_) =>
                                                      DateRangePage(),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: UserTransactionTile(
                                          transaction:
                                              state.transactionList[index],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                } else {
                  return CommonErrorText();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
