import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double totalIncome;
  final double totalOutcome;

  const BalanceCard({
    Key? key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalOutcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Saldo com as transações agendadas:",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$')
                    .format(totalBalance),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 18),
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
                            color: Theme.of(context).textTheme.bodyText2!.color,
                          ),
                          const SizedBox(width: 4),
                          const Text("Entradas:"),
                        ],
                      ),
                      Text(
                        NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$')
                            .format(totalIncome),
                        style: const TextStyle(
                          fontSize: 24,
                        ),
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
                            color: Theme.of(context).textTheme.bodyText2!.color,
                          ),
                          const SizedBox(width: 4),
                          const Text("Saídas:"),
                        ],
                      ),
                      Text(
                        NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$')
                            .format(totalOutcome),
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
