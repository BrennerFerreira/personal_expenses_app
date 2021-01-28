import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class UserTransactionTile extends StatelessWidget {
  final UserTransaction transaction;
  final bool isDense;
  const UserTransactionTile({
    required this.transaction,
    this.isDense = false,
  });

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return ListTile(
      dense: isDense,
      leading: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat(DateFormat.DAY, 'pt-BR').format(transaction.date),
          ),
          Text(
            DateFormat(DateFormat.ABBR_MONTH, 'pt-BR')
                .format(transaction.date)
                .toUpperCase(),
          ),
        ],
      ),
      title: Text(transaction.title),
      subtitle: Text(transaction.account),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (transaction.isIncome)
            Icon(
              Icons.arrow_upward,
              color: Theme.of(context).textTheme.bodyText2!.color,
              size: 26,
            )
          else
            Icon(
              Icons.arrow_downward,
              color: Theme.of(context).textTheme.bodyText2!.color,
              size: 26,
            ),
          const SizedBox(width: 5),
          Text(
            NumberFormat.currency(locale: 'pt-Br', symbol: "R\$")
                .format(transaction.price),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
