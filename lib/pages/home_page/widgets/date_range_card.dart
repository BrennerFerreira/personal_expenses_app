import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
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
                  return Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const Text(
                                "Este mês:",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                NumberFormat.currency(
                                  locale: 'pt-BR',
                                  symbol: "R\$",
                                ).format(state.balance),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                            NumberFormat.currency(
                                              locale: 'pt-BR',
                                              symbol: "R\$",
                                            ).format(state.income),
                                            style: const TextStyle(
                                              fontSize: 24,
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
                                            NumberFormat.currency(
                                              locale: 'pt-BR',
                                              symbol: "R\$",
                                            ).format(state.outcome),
                                            style: const TextStyle(
                                              fontSize: 24,
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
                        ),
                      ),
                      const Text(
                        "Mais detalhes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
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
