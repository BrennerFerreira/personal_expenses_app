import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/pages/account_details_page/account_details_page.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/transaction_details_page/transaction_detail_page.dart';

class AccountTransactionList extends StatelessWidget {
  final List<UserTransaction> transactionList;
  final String account;

  const AccountTransactionList({
    Key? key,
    required this.transactionList,
    required this.account,
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
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => TransactionDetailsPage(
                          transaction: transactionList[index],
                          lastPage: MaterialPageRoute(
                            builder: (_) => AccountDetailsPage(
                              account: account,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: UserTransactionTile(
                    transaction: transactionList[index],
                  ),
                );
              },
            ),
    );
  }
}
