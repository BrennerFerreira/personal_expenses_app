import 'package:personal_expenses/constants/transaction_table_constants.dart';
import 'package:personal_expenses/database/transaction_helper.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class AccountRepository {
  final helper = TransactionHelper();

  Future<List<UserTransaction>> getAllTransactionsByAccount(
      String account) async {
    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> listMap = await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "WHERE $ACCOUNT_COLUMN == '$account' "
      "ORDER BY $DATE_COLUMN DESC",
    );
    final List<UserTransaction> transactionList = [];
    for (final Map<String, dynamic> map in listMap) {
      transactionList.add(UserTransaction.fromMap(map));
    }
    return transactionList;
  }

  Future<List<String>> getAllAccounts() async {
    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> listMap = await dbTransaction.rawQuery(
      "SELECT DISTINCT($ACCOUNT_COLUMN) AS ACCOUNT "
      "FROM $TRANSACTION_TABLE "
      "ORDER BY $ACCOUNT_COLUMN ASC",
    );
    final List<String> accountList = [];
    for (final Map<String, dynamic> map in listMap) {
      accountList.add(map['ACCOUNT'] as String);
    }
    return accountList;
  }
}
