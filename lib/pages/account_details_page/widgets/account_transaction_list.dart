import 'package:flutter/material.dart';

import '../../../models/transaction.dart';
import '../../common/user_transaction_tile.dart';
import '../../transaction_details_page/transaction_detail_page.dart';
import '../account_details_page.dart';

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
