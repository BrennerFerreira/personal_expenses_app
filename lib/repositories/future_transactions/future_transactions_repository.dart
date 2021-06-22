import 'package:sqflite/sqflite.dart';

import '../../constants/transaction_table_constants.dart';
import '../../database/transaction_helper.dart';
import '../../models/transaction.dart';

class FutureTransactionsRepository {
  final helper = TransactionHelper();

  Future<List<UserTransaction>> getAllFutureTransactions() async {
    final int todayMilliseconds = DateTime.now().millisecondsSinceEpoch;

    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> listMap = await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "WHERE $DATE_COLUMN > $todayMilliseconds "
      "ORDER BY $DATE_COLUMN ASC",
    );
    final List<UserTransaction> transactionList = [];
    for (final Map<String, dynamic> map in listMap) {
      transactionList.add(UserTransaction.fromMap(map));
    }
    return transactionList;
  }
}
