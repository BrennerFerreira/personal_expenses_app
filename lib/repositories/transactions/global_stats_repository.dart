import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../constants/transaction_table_constants.dart';
import '../../database/transaction_helper.dart';
import '../../models/transaction.dart';

class GlobalStatsRepository {
  final helper = TransactionHelper();

  Future<Map<String, double>> pastBalance() async {
    final todayDate = DateTime.now().millisecondsSinceEpoch;

    final Database dbTransaction = await helper.db;

    final List<Map<String, dynamic>> incomeMap = await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_INCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'true' "
      "AND $DATE_COLUMN < $todayDate",
    );
    final double totalIncome = (incomeMap[0]['TOTAL_INCOME'] ?? 0.0) as double;

    final List<Map<String, dynamic>> outcomeMap = await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_OUTCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'false' "
      "AND $DATE_COLUMN < $todayDate",
    );
    final double totalOutcome =
        (outcomeMap[0]['TOTAL_OUTCOME'] ?? 0.0) as double;

    final double totalBalance = totalIncome - totalOutcome;

    return {
      'totalBalance': totalBalance,
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome
    };
  }

  Future<Map<String, double>> totalBalance() async {
    final Database dbTransaction = await helper.db;

    final List<Map<String, dynamic>> incomeMap = await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_INCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'true'",
    );
    final double totalIncome = (incomeMap[0]['TOTAL_INCOME'] ?? 0.0) as double;

    final List<Map<String, dynamic>> outcomeMap = await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_OUTCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'false'",
    );
    final double totalOutcome =
        (outcomeMap[0]['TOTAL_OUTCOME'] ?? 0.0) as double;

    final double totalBalance = totalIncome - totalOutcome;

    return {
      'totalBalance': totalBalance,
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome
    };
  }

  Future<Map<String, dynamic>> getBalanceByDateRange(
      DateTimeRange dateRange) async {
    final DateTime initialDate = dateRange.start;
    final int millisecondsInitialDate = initialDate.millisecondsSinceEpoch;
    final DateTime finalDate = dateRange.end;
    final int millisecondsFinalDate = finalDate.millisecondsSinceEpoch;

    final Database dbTransaction = await helper.db;

    final List<Map<String, dynamic>> incomeMapList =
        await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS $PRICE_COLUMN "
      "FROM $TRANSACTION_TABLE "
      "WHERE ($DATE_COLUMN BETWEEN $millisecondsInitialDate AND $millisecondsFinalDate) "
      "AND $IS_INCOME_COLUMN == 'true'",
    );
    final double income = (incomeMapList[0][PRICE_COLUMN] ?? 0.0) as double;

    final List<Map<String, dynamic>> outcomeMapList =
        await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS $PRICE_COLUMN "
      "FROM $TRANSACTION_TABLE "
      "WHERE ($DATE_COLUMN BETWEEN $millisecondsInitialDate AND $millisecondsFinalDate) "
      "AND $IS_INCOME_COLUMN == 'false'",
    );
    final double outcome = (outcomeMapList[0][PRICE_COLUMN] ?? 0.0) as double;

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
      "WHERE ($DATE_COLUMN BETWEEN $millisecondsInitialDate AND $millisecondsFinalDate) "
      "AND $IS_INCOME_COLUMN == 'true' "
      "AND $IS_BETWEEN_ACCOUNTS_COLUMN == 'false'",
    );

    final UserTransaction? highestIncomeTransaction =
        highestIncome[0][ID_COLUMN] == null
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
      "WHERE ($DATE_COLUMN BETWEEN $millisecondsInitialDate AND $millisecondsFinalDate) "
      "AND $IS_INCOME_COLUMN == 'false' "
      "AND $IS_BETWEEN_ACCOUNTS_COLUMN == 'false'",
    );

    final UserTransaction? highestOutcomeTransaction =
        highestOutcome[0][ID_COLUMN] == null
            ? null
            : UserTransaction.fromMap(highestOutcome.first);

    return {
      'totalIncome': income,
      'totalOutcome': outcome,
      'highestIncome': highestIncomeTransaction,
      'highestOutcome': highestOutcomeTransaction,
    };
  }
}
