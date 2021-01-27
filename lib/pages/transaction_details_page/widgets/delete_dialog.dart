import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/transaction_details_page/transaction_details_page_bloc.dart';
import 'package:personal_expenses/models/transaction.dart';

class DeleteDialog extends StatelessWidget {
  final UserTransaction transaction;
  final TransactionDetailsBloc transactionDetailsBloc;

  const DeleteDialog({
    Key? key,
    required this.transactionDetailsBloc,
    required this.transaction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Excluir transação",
        style: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Tem certeza que deseja excluir esta transação? Esta ação não pode ser desfeita.",
          ),
          if (transaction.isInstallment) const SizedBox(height: 20),
          if (transaction.isInstallment)
            BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
              value: transactionDetailsBloc,
              builder: (context, state) {
                return CheckboxListTile(
                  title:
                      const Text("Excluir todas as parcelas desta transação."),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  value: state.deleteAllInstallments,
                  onChanged: (newDeleteAllTransactions) =>
                      transactionDetailsBloc.add(
                    DeleteAllInstallmentsChanged(
                      newDeleteAllTransactions: newDeleteAllTransactions!,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Cancelar"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            "Excluir",
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ],
    );
  }
}
