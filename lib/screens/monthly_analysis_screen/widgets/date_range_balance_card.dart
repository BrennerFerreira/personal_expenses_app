import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';

class DateRangeBalanceCard extends StatelessWidget {
  final double totalIncome;
  final double totalOutcome;
  final UserTransaction? highestIncome;
  final UserTransaction? highestOutcome;

  const DateRangeBalanceCard({
    Key? key,
    required this.totalIncome,
    required this.totalOutcome,
    required this.highestIncome,
    required this.highestOutcome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            if (highestIncome != null) const SizedBox(height: 10),
            if (highestIncome != null)
              const Center(
                child: Text(
                  "Maior receita no período:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (highestIncome != null)
              IgnorePointer(
                child: UserTransactionTile(
                  transaction: highestIncome!,
                  elevation: 0,
                  onWillPopDetails: () async {
                    return true;
                  },
                ),
              ),
            if (highestOutcome != null) const SizedBox(height: 10),
            if (highestOutcome != null)
              const Center(
                child: Text(
                  "Maior despesa no período:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (highestOutcome != null)
              IgnorePointer(
                child: UserTransactionTile(
                  transaction: highestOutcome!,
                  elevation: 0,
                  onWillPopDetails: () async {
                    return true;
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
