import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';

class FutureTransactionsBalanceCard extends StatelessWidget {
  final double totalIncome;
  final double totalOutcome;
  final UserTransaction? highestIncome;
  final UserTransaction? highestOutcome;

  const FutureTransactionsBalanceCard({
    Key? key,
    required this.totalIncome,
    required this.totalOutcome,
    required this.highestIncome,
    required this.highestOutcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_upward,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Entradas:",
                      style: TextStyle(),
                    ),
                  ],
                ),
                Text(
                  "R\$ ${totalIncome.toStringAsFixed(2).replaceAll(".", ",")}",
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.arrow_downward,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Saídas:",
                      style: TextStyle(),
                    ),
                  ],
                ),
                Text(
                  "R\$ ${totalOutcome.toStringAsFixed(2).replaceAll(".", ",")}",
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (highestIncome != null) const SizedBox(height: 20),
            if (highestIncome != null) const Text("Maior receita futura:"),
            if (highestIncome != null)
              UserTransactionTile(
                transaction: highestIncome!,
                elevation: 0,
              ),
            if (highestOutcome != null) const SizedBox(height: 20),
            if (highestOutcome != null) const Text("Maior despesa futura:"),
            if (highestOutcome != null)
              UserTransactionTile(
                transaction: highestOutcome!,
              ),
          ],
        ),
      ],
    );
  }
}
