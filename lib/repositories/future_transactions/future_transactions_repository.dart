import 'package:personal_expenses/constants/transaction_table_constants.dart';
import 'package:personal_expenses/database/transaction_helper.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

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
