import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/blocs/filtered_transactions/filtered_transactions_bloc.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/models/visibility_filter.dart';
import 'package:personal_expenses/screens/common/transaction_detail.dart';

class UserTransactionTile extends StatelessWidget {
  final UserTransaction transaction;
  final double? elevation;
  final bool isDense;
  const UserTransactionTile({
    required this.transaction,
    this.isDense = true,
    this.elevation,
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
            "R\$ ${transaction.price.toStringAsFixed(2).replaceAll(".", ",")}",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      onTap: () async {
        final bool? transactionEdited = await showDialog(
          context: context,
          builder: (context) => UserTransactionDetail(
            transaction: transaction,
          ),
        );
        if (transactionEdited != null) {
          BlocProvider.of<FilteredTransactionsBloc>(context).add(
            const FilterUpdated(
              VisibilityFilter.lastSevenDays,
            ),
          );
        }
      },
    );
  }
}
