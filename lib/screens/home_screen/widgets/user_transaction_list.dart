import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';

class UserTransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FilteredTransactionsBloc, FilteredTransactionsState>(
        builder: (context, state) {
          if (state is FilteredTransactionsLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else if (state is FilteredTransactionsLoadSuccess) {
            final List<UserTransaction> transactionList =
                state.filteredTransactions;
            return transactionList.isEmpty
                ? const Center(
                    child: Text("Nenhuma transação cadastrada."),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactionList.length,
                    itemBuilder: (context, index) {
                      return UserTransactionTile(
                        transaction: transactionList[index],
                        onWillPopDetails: () async {
                          return true;
                        },
                      );
                    },
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
