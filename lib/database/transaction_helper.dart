import 'package:personal_expenses/constants/transaction_table_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TransactionHelper {
  static final TransactionHelper _instance = TransactionHelper.internal();

  factory TransactionHelper() => _instance;

  TransactionHelper.internal();

  Database? _db;

  Future<Database> get db async {
    return _db ?? await initDb();
  }

  Future<Database> initDb() async {
    final String databasePath = await getDatabasesPath() as String;
    final String path = join(databasePath, "personal_expenses_transactions.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute(
          "CREATE TABLE $TRANSACTION_TABLE ( "
          "$ID_COLUMN INTEGER PRIMARY KEY, "
          "$TITLE_COLUMN TEXT, "
          "$ACCOUNT_COLUMN TEXT, "
          "$IS_INSTALLMENT_COLUMN TEXT, "
          "$NUMBER_INSTALLMENTS_COLUMN INTEGER, "
          "$INSTALLMENT_ID_COLUMN TEXT, "
          "$IS_BETWEEN_ACCOUNTS_COLUMN TEXT, "
          "$BETWEEN_ACCOUNTS_ID_COLUMN TEXT, "
          "$DATE_COLUMN INTEGER, "
          "$SAVED_AT_COLUMN INTEGER, "
          "$IS_INCOME_COLUMN TEXT, "
          "$PRICE_COLUMN REAL)",
        );
      },
    );
  }
}
