import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';
import 'package:personal_expenses/screens/home_screen/widgets/blurred_container.dart';

class HomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlurredContainer(
      blocBuilder: BlocBuilder<GlobalStatsBloc, GlobalStatsState>(
        builder: (context, state) {
          if (state is GlobalStatsLoadInProgress) {
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
          } else if (state is GlobalStatsLoadSuccess) {
            return Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            FontAwesomeIcons.wallet,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Saldo atual:",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "R\$ ${state.totalBalance.toStringAsFixed(2).replaceAll(".", ",")}",
                        style: const TextStyle(
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text("Última transação realizada:"),
                      BlocBuilder<LastAndNextTransactionsBloc,
                          LastAndNextTransactionsState>(
                        builder: (context, state) {
                          if (state is LastAndNextTransactionsLoadInProgress) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).accentColor,
                                ),
                              ),
                            );
                          } else if (state
                              is LastAndNextTransactionsLoadSuccess) {
                            if (state.lastTransaction == null) {
                              return const Text(
                                "Não há nenhuma transação realizada.",
                              );
                            } else {
                              return UserTransactionTile(
                                transaction: state.lastTransaction!,
                                onWillPopDetails: () async {
                                  return true;
                                },
                              );
                            }
                          } else {
                            return const Text(
                              "Erro ao carregar a última transação.",
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
            return const Text(
              "Erro aos calcular os dados. Por favor, reinicie o aplicativo",
              textAlign: TextAlign.center,
            );
          }
        },
      ),
    );
  }
}
