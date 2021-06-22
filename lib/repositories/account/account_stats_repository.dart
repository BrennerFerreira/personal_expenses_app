import 'package:sqflite/sqflite.dart';

import '../../constants/transaction_table_constants.dart';
import '../../database/transaction_helper.dart';

class AccountStatsRepository {
  final helper = TransactionHelper();

  Future<Map<String, double>> accountBalance(String account) async {
    final Database dbTransaction = await helper.db;

    final List<Map<String, dynamic>> totalIncomeMap =
        await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_INCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'true' "
      "AND $ACCOUNT_COLUMN == '$account' ",
    );

    final double totalIncome =
        (totalIncomeMap[0]['TOTAL_INCOME'] ?? 0.0) as double;

    final List<Map<String, dynamic>> totalOutcomeMap =
        await dbTransaction.rawQuery(
      "SELECT SUM($PRICE_COLUMN) AS TOTAL_OUTCOME "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'false' "
      "AND $ACCOUNT_COLUMN == '$account' ",
    );

    final double totalOutcome =
        (totalOutcomeMap[0]['TOTAL_OUTCOME'] ?? 0.0) as double;

    final double totalBalance = totalIncome - totalOutcome;

    return {
      'totalBalance': totalBalance,
      'totalIncome': totalIncome,
      'totalOutcome': totalOutcome
    };
  }

  Future<List<Map<String, double>>> getAllAcountsBalance() async {
    final Database dbTransaction = await helper.db;

    final Map<String, Map<String, double>> accountBalanceMap = {};

    final List<Map<String, dynamic>> incomeListMap =
        await dbTransaction.rawQuery(
      "SELECT $ACCOUNT_COLUMN, "
      "SUM($PRICE_COLUMN) AS $PRICE_COLUMN "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'true' "
      "GROUP BY $ACCOUNT_COLUMN",
    );

    for (final Map<String, dynamic> incomeMap in incomeListMap) {
      accountBalanceMap[incomeMap[ACCOUNT_COLUMN] as String] = {
        "income": (incomeMap[PRICE_COLUMN] ?? 0.0) as double,
        "outcome": 0.0,
      };
    }

    final List<Map<String, dynamic>> outcomeListMap =
        await dbTransaction.rawQuery(
      "SELECT $ACCOUNT_COLUMN, "
      "SUM($PRICE_COLUMN) AS $PRICE_COLUMN "
      "FROM $TRANSACTION_TABLE "
      "WHERE $IS_INCOME_COLUMN == 'false' "
      "GROUP BY $ACCOUNT_COLUMN",
    );
    for (final Map<String, dynamic> outcomeMap in outcomeListMap) {
      if (accountBalanceMap[outcomeMap[ACCOUNT_COLUMN] as String] == null) {
        accountBalanceMap[outcomeMap[ACCOUNT_COLUMN] as String] = {
          "income": 0.0,
          "outcome": (outcomeMap[PRICE_COLUMN] ?? 0.0) as double,
        };
      } else {
        accountBalanceMap[outcomeMap[ACCOUNT_COLUMN] as String]!.addAll(
          {
            "outcome": (outcomeMap[PRICE_COLUMN] ?? 0.0) as double,
          },
        );
      }
    }
    final List<Map<String, double>> accountBalanceList = [];
    accountBalanceMap.forEach((key, value) {
      accountBalanceList.add({key: value["income"]! - value["outcome"]!});
    });
    accountBalanceList.sort(
      (a, b) => a.values.first.compareTo(b.values.first),
    );

    return accountBalanceList.reversed.toList();
  }
}
