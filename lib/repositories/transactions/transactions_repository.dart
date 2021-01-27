import 'package:flutter/material.dart';
import 'package:personal_expenses/constants/transaction_table_constants.dart';
import 'package:personal_expenses/database/transaction_helper.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class TransactionRepository {
  final helper = TransactionHelper();

  Future<UserTransaction> saveTransaction(UserTransaction transaction) async {
    final Database dbTransaction = await helper.db;
    transaction.id = await dbTransaction.insert(
      TRANSACTION_TABLE,
      transaction.toMap(),
    );
    return transaction;
  }

  Future<UserTransaction?> getTransaction(int id) async {
    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> maps = await dbTransaction.query(
      TRANSACTION_TABLE,
      where: "$ID_COLUMN == ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return UserTransaction.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Map<String, UserTransaction>> getBetweenAccountsTransaction(
      String betweenAccountsId) async {
    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> incomeTransaction =
        await dbTransaction.query(
      TRANSACTION_TABLE,
      where: "$BETWEEN_ACCOUNTS_ID_COLUMN == ? AND $IS_INCOME_COLUMN == ?",
      whereArgs: [betweenAccountsId, 'true'],
    );

    final List<Map<String, dynamic>> outcomeTransaction =
        await dbTransaction.query(
      TRANSACTION_TABLE,
      where: "$BETWEEN_ACCOUNTS_ID_COLUMN == ? AND $IS_INCOME_COLUMN == ?",
      whereArgs: [betweenAccountsId, 'false'],
    );
    final Map<String, UserTransaction> betweenAccountsTransactions = {
      'income': UserTransaction.fromMap(incomeTransaction[0]),
      'outcome': UserTransaction.fromMap(outcomeTransaction[0]),
    };
    return betweenAccountsTransactions;
  }

  Future<int> deleteTransaction(int id) async {
    final Database dbTransaction = await helper.db;
    return dbTransaction.delete(
      TRANSACTION_TABLE,
      where: "$ID_COLUMN == ?",
      whereArgs: [id],
    );
  }

  Future<int> updateTransaction(UserTransaction transaction) async {
    final Database dbTransaction = await helper.db;
    return dbTransaction.update(
      TRANSACTION_TABLE,
      transaction.toMap(),
      where: "$ID_COLUMN == ?",
      whereArgs: [transaction.id],
    );
  }

  Future<List<UserTransaction>> getAllTransactionsLimitedByDate(
      int daysBefore) async {
    final DateTime baseDate = DateTime.now().subtract(
      Duration(days: daysBefore),
    );
    final int baseMilliseconds = baseDate.millisecondsSinceEpoch;
    final int todayMilliseconds = DateTime.now().millisecondsSinceEpoch;

    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> listMap = await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "WHERE $DATE_COLUMN BETWEEN $baseMilliseconds AND $todayMilliseconds "
      "ORDER BY $DATE_COLUMN DESC",
    );
    final List<UserTransaction> transactionList = [];
    if (listMap.isNotEmpty) {
      for (final Map<String, dynamic> map in listMap) {
        transactionList.add(UserTransaction.fromMap(map));
      }
    }
    return transactionList;
  }

  Future<List<UserTransaction>> getAllTransactions() async {
    final Database dbTransaction = await helper.db;
    final List<Map<String, dynamic>> listMap = await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "ORDER BY $DATE_COLUMN DESC",
    );
    final List<UserTransaction> transactionList = [];
    for (final Map<String, dynamic> map in listMap) {
      transactionList.add(UserTransaction.fromMap(map));
    }
    return transactionList;
  }

  Future<List<UserTransaction>> getTransactionByDateRange(
      DateTimeRange dateRange) async {
    final DateTime initialDate = dateRange.start;
    final int millisecondsInitialDate = initialDate.millisecondsSinceEpoch;
    final DateTime finalDate = dateRange.end;
    final int millisecondsFinalDate = finalDate.millisecondsSinceEpoch;

    final Database dbTransaction = await helper.db;

    final List<Map<String, dynamic>> mapList = await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "WHERE $DATE_COLUMN BETWEEN $millisecondsInitialDate AND $millisecondsFinalDate "
      "ORDER BY $DATE_COLUMN DESC",
    );
    final List<UserTransaction> transactionList = [];

    for (final Map<String, dynamic> map in mapList) {
      transactionList.add(UserTransaction.fromMap(map));
    }

    return transactionList;
  }

  Future<UserTransaction?> getLastTransaction() async {
    final Database dbTransaction = await helper.db;

    final int todayDate = DateTime.now().millisecondsSinceEpoch;

    final List<Map<String, dynamic>> transactionListMap =
        await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "WHERE $DATE_COLUMN < $todayDate "
      "ORDER BY $DATE_COLUMN DESC "
      "LIMIT 1",
    );
    if (transactionListMap.isEmpty) {
      return null;
    } else {
      return UserTransaction.fromMap(transactionListMap.first);
    }
  }

  Future<UserTransaction?> getNextTransaction() async {
    final Database dbTransaction = await helper.db;

    final int todayDate = DateTime.now().millisecondsSinceEpoch;

    final List<Map<String, dynamic>> transactionListMap =
        await dbTransaction.rawQuery(
      "SELECT * "
      "FROM $TRANSACTION_TABLE "
      "WHERE $DATE_COLUMN > $todayDate "
      "ORDER BY $DATE_COLUMN ASC "
      "LIMIT 1",
    );
    if (transactionListMap.isEmpty) {
      return null;
    } else {
      return UserTransaction.fromMap(transactionListMap.first);
    }
  }

  Future<int> deleteTransactionByInstallmentId(String installmentId) async {
    final Database dbTransaction = await helper.db;
    return dbTransaction.delete(
      TRANSACTION_TABLE,
      where: "$INSTALLMENT_ID_COLUMN == ?",
      whereArgs: [installmentId],
    );
  }

  Future<int> deleteTransactionByBetweenAccounId(
      String betweenAccountsId) async {
    final Database dbTransaction = await helper.db;
    return dbTransaction.delete(
      TRANSACTION_TABLE,
      where: "$BETWEEN_ACCOUNTS_ID_COLUMN == ?",
      whereArgs: [betweenAccountsId],
    );
  }
}
