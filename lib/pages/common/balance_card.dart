import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.wallet,
                    size: 18,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Saldo atual:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "R\$ ${totalBalance.toStringAsFixed(2).replaceAll(".", ",")}",
                style: const TextStyle(
                  fontSize: 36,
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
                        "R\$ ${totalIncome.toStringAsFixed(2).replaceAll(".", ",")}",
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
                            color: Theme.of(context).textTheme.bodyText2!.color,
                          ),
                          const SizedBox(width: 4),
                          const Text("Saídas:"),
                        ],
                      ),
                      Text(
                        "R\$ ${totalOutcome.toStringAsFixed(2).replaceAll(".", ",")}",
                        style: const TextStyle(fontSize: 28),
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
