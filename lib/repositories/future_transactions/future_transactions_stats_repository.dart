import 'package:personal_expenses/constants/transaction_table_constants.dart';
import 'package:personal_expenses/database/transaction_helper.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class FutureTransactionsStatsRepository {
  final helper = TransactionHelper();

  Future<Map<String, dynamic>> futureBalance() async {
    final todayDate = DateTime.now().millisecondsSinceEpoch;

    final Database dbTransaction = await helper.db;

    final List<Map<String, dynamic>> incomeMap = await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_INCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE ($IS_INCOME_COLUMN == 'true') AND ($DATE_COLUMN > $todayDate)",
    );
    final double totalIncome = (incomeMap[0]['TOTAL_INCOME'] ?? 0.0) as double;

    final List<Map<String, dynamic>> outcomeMap = await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_OUTCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE ($IS_INCOME_COLUMN == 'false') AND ($DATE_COLUMN > $todayDate)",
    );
    final double totalOutcome =
        (outcomeMap[0]['TOTAL_OUTCOME'] ?? 0.0) as double;

    final List<Map<String, dynamic>> highestIncome =
        await dbTransaction.rawQuery(
      "SELECT $ID_COLUMN, "
      "$TITLE_COLUMN, "
      "$ACCOUNT_COLUMN, "
      "$IS_INCOME_COLUMN, "
      "$DATE_COLUMN, "
      "$IS_INSTALLMENT_COLUMN, "
      "$NUMBER_INSTALLMENTS_COLUMN, "
      "$INSTALLMENT_ID_COLUMN, "
      "$IS_BETWEEN_ACCOUNTS_COLUMN, "
      "$BETWEEN_ACCOUNTS_ID_COLUMN, "
      "$SAVED_AT_COLUMN, "
      "MAX($PRICE_COLUMN) AS $PRICE_COLUMN "
      "FROM $TRANSACTION_TABLE "
      "WHERE ($IS_INCOME_COLUMN == 'true') "
      "AND ($DATE_COLUMN > $todayDate) "
      "AND ($IS_BETWEEN_ACCOUNTS_COLUMN == 'false')",
    );
    final UserTransaction? highestIncomeTransaction =
        highestIncome.first[ID_COLUMN] == null
            ? null
            : UserTransaction.fromMap(highestIncome.first);

    final List<Map<String, dynamic>> highestOutcome =
        await dbTransaction.rawQuery(
      "SELECT $ID_COLUMN, "
      "$TITLE_COLUMN, "
      "$ACCOUNT_COLUMN, "
      "$IS_INCOME_COLUMN, "
      "$DATE_COLUMN, "
      "$IS_INSTALLMENT_COLUMN, "
      "$NUMBER_INSTALLMENTS_COLUMN, "
      "$INSTALLMENT_ID_COLUMN, "
      "$IS_BETWEEN_ACCOUNTS_COLUMN, "
      "$BETWEEN_ACCOUNTS_ID_COLUMN, "
      "$SAVED_AT_COLUMN, "
      "MAX($PRICE_COLUMN) AS $PRICE_COLUMN "
      "FROM $TRANSACTION_TABLE "
      "WHERE ($IS_INCOME_COLUMN == 'false') "
      "AND ($DATE_COLUMN > $todayDate) "
      "AND ($IS_BETWEEN_ACCOUNTS_COLUMN == 'false')",
    );

    final UserTransaction? highestOutcomeTransaction =
        highestOutcome[0][ID_COLUMN] == null
            ? null
            : UserTransaction.fromMap(highestOutcome.first);

    return {
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome,
      'highestIncome': highestIncomeTransaction,
      'highestOutcome': highestOutcomeTransaction,
    };
  }
}
