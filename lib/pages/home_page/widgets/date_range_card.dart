import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/date_range_page/date_range_page.dart';

class DateRangeTransactionsCard extends StatefulWidget {
  @override
  _DateRangeTransactionsCardState createState() =>
      _DateRangeTransactionsCardState();
}

class _DateRangeTransactionsCardState extends State<DateRangeTransactionsCard> {
  late DateRangeTransactionsCardBloc dateRangeTransactionsCardBloc;

  @override
  void initState() {
    super.initState();
    dateRangeTransactionsCardBloc = DateRangeTransactionsCardBloc()
      ..add(
        const UpdateDateRangeTransactionsCard(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => DateRangePage(),
            ),
          );
        },
        child: BlurredCard(
          child: BlocProvider<DateRangeTransactionsCardBloc>(
            create: (context) => DateRangeTransactionsCardBloc(),
            child: BlocBuilder<DateRangeTransactionsCardBloc,
                DateRangeTransactionsCardState>(
              value: dateRangeTransactionsCardBloc,
              builder: (context, state) {
                if (state is DateRangeTransactionsCardLoadInProgress) {
                  return CommonCircularIndicator();
                } else if (state is DateRangeTransactionsCardLoadSuccess) {
                  return Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Text(
                          "Este mês:",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "R\$ ${state.balance.toStringAsFixed(2).replaceAll(".", ",")}",
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Entradas"),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_upward,
                                      size: 25,
                                    ),
                                    Text(
                                      "R\$ ${state.income.toStringAsFixed(2).replaceAll(".", ",")}",
                                      style: const TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text("Saídas"),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_downward,
                                      size: 25,
                                    ),
                                    Text(
                                      "R\$ ${state.outcome.toStringAsFixed(2).replaceAll(".", ",")}",
                                      style: const TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return CommonErrorText();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
