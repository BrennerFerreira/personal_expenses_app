import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/screens/common/user_transaction_tile.dart';

class AccountTransactionList extends StatelessWidget {
  final List<UserTransaction> transactionList;
  final Future<bool> Function() onWillPop;

  const AccountTransactionList({
    Key? key,
    required this.transactionList,
    required this.onWillPop,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactionList.isEmpty
          ? const Center(
              child: Text("Nenhuma transação cadastrada."),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: transactionList.length,
              itemBuilder: (context, index) {
                return UserTransactionTile(
                  transaction: transactionList[index],
                  onWillPopDetails: onWillPop,
                );
              },
            ),
    );
  }
}
