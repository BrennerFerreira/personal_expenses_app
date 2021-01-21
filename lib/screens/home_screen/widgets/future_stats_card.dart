import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';
import 'package:personal_expenses/screens/future_transactions_screen/future_transactions_screen.dart';
import 'package:personal_expenses/screens/home_screen/widgets/blurred_container.dart';

class FutureStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FutureTransactionsScreen(),
          ),
        );
      },
      child: BlurredContainer(
        blocBuilder: BlocBuilder<FutureTransactionsStatsBloc,
            FutureTransactionsStatsState>(
          builder: (context, state) {
            if (state is FutureTransactionsStatsLoadInProgress) {
              return SizedBox(
                height: 250,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor,
                    ),
                  ),
                ),
              );
            } else if (state is FutureTransactionsStatsLoadSuccess) {
              return Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Transações agendadas:",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text("Entradas"),
                                  ],
                                ),
                                Text(
                                  "R\$ ${state.totalIncome.toStringAsFixed(2).replaceAll(".", ",")}",
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text("Saídas"),
                                  ],
                                ),
                                Text(
                                  "R\$ ${state.totalOutcome.toStringAsFixed(2).replaceAll(".", ",")}",
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text("Próxima transação agendada:"),
                        BlocBuilder<LastAndNextTransactionsBloc,
                            LastAndNextTransactionsState>(
                          builder: (context, state) {
                            if (state
                                is LastAndNextTransactionsLoadInProgress) {
                              return Center(
                                child: CircularProgressIndicator.adaptive(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).accentColor,
                                  ),
                                ),
                              );
                            } else if (state
                                is LastAndNextTransactionsLoadSuccess) {
                              if (state.nextTransaction == null) {
                                return const Center(
                                  child: Text(
                                    "Não há nenhuma transação agendada.",
                                  ),
                                );
                              } else {
                                return UserTransactionTile(
                                  isDense: false,
                                  transaction: state.nextTransaction!,
                                );
                              }
                            } else {
                              return const Center(
                                child: Text(
                                  "Erro ao carregar a próxima transação.",
                                ),
                              );
                            }
                          },
                          buildWhen: (previousState, currentState) {
                            return previousState
                                    is LastAndNextTransactionsLoadInProgress &&
                                currentState
                                    is LastAndNextTransactionsLoadSuccess;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Erro aos calcular os dados. Por favor, reinicie o aplicativo",
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
