import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/future_transactions_card/future_transactions_card_bloc.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/future_transactions_page/future_transactions_page.dart';

class FutureTransactionsCard extends StatefulWidget {
  @override
  _FutureTransactionsCardState createState() => _FutureTransactionsCardState();
}

class _FutureTransactionsCardState extends State<FutureTransactionsCard> {
  late FutureTransactionsCardBloc futureTransactionsCardBloc;

  @override
  void initState() {
    super.initState();
    futureTransactionsCardBloc = FutureTransactionsCardBloc()
      ..add(
        const UpdateFutureTransactionsCard(),
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
              builder: (_) => FutureTransactionsPage(),
            ),
          );
        },
        child: BlurredCard(
          child: BlocProvider<FutureTransactionsCardBloc>(
            create: (context) => FutureTransactionsCardBloc(),
            child: BlocBuilder<FutureTransactionsCardBloc,
                FutureTransactionsCardState>(
              value: futureTransactionsCardBloc,
              builder: (context, state) {
                if (state is FutureTransactionsCardLoadInProgress) {
                  return CommonCircularIndicator();
                } else if (state is FutureTransactionsCardLoadSuccess) {
                  return Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const Text(
                                "Transações agendadas:",
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
                                            size: 30,
                                          ),
                                          Text(
                                            "R\$ ${state.income.toStringAsFixed(2).replaceAll(".", ",")}",
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
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
                                            size: 30,
                                          ),
                                          Text(
                                            "R\$ ${state.outcome.toStringAsFixed(2).replaceAll(".", ",")}",
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              if (state.nextTransaction != null)
                                const Text(
                                  "Próxima transação agendada:",
                                  textAlign: TextAlign.center,
                                ),
                              if (state.nextTransaction != null)
                                UserTransactionTile(
                                    transaction: state.nextTransaction!)
                              else
                                const Text(
                                  "Nenhuma transação agendada.",
                                  textAlign: TextAlign.center,
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
