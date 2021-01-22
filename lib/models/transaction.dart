import 'package:equatable/equatable.dart';

import 'package:personal_expenses/constants/transaction_table_constants.dart';

class UserTransaction extends Equatable {
  int? id;
  String title;
  String account;
  bool isInstallment;
  int numberOfInstallments;
  String? installmentId;
  bool isBetweenAccounts;
  String? betweenAccountsId;
  DateTime date;
  DateTime savedAt;
  bool isIncome;
  double price;

  UserTransaction({
    this.id,
    required this.title,
    required this.account,
    this.isInstallment = false,
    this.numberOfInstallments = 1,
    this.installmentId,
    this.isBetweenAccounts = false,
    this.betweenAccountsId,
    required this.date,
    required this.savedAt,
    this.isIncome = false,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      ID_COLUMN: id,
      TITLE_COLUMN: title,
      ACCOUNT_COLUMN: account,
      IS_INSTALLMENT_COLUMN: isInstallment.toString(),
      NUMBER_INSTALLMENTS_COLUMN: numberOfInstallments,
      INSTALLMENT_ID_COLUMN: installmentId.toString(),
      IS_BETWEEN_ACCOUNTS_COLUMN: isBetweenAccounts.toString(),
      BETWEEN_ACCOUNTS_ID_COLUMN: betweenAccountsId.toString(),
      DATE_COLUMN: date.millisecondsSinceEpoch,
      SAVED_AT_COLUMN: savedAt.millisecondsSinceEpoch,
      IS_INCOME_COLUMN: isIncome.toString(),
      PRICE_COLUMN: price,
    };
  }

  factory UserTransaction.fromMap(Map<String, dynamic> map) {
    return UserTransaction(
      id: map[ID_COLUMN] as int,
      title: map[TITLE_COLUMN] as String,
      account: map[ACCOUNT_COLUMN] as String,
      isInstallment: map[IS_INSTALLMENT_COLUMN] == 'true',
      numberOfInstallments: map[NUMBER_INSTALLMENTS_COLUMN] as int,
      installmentId: map[INSTALLMENT_ID_COLUMN] == 'null'
          ? null
          : map[INSTALLMENT_ID_COLUMN] as String,
      isBetweenAccounts: map[IS_BETWEEN_ACCOUNTS_COLUMN] == 'true',
      betweenAccountsId: map[BETWEEN_ACCOUNTS_ID_COLUMN] == 'null'
          ? null
          : map[BETWEEN_ACCOUNTS_ID_COLUMN] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map[DATE_COLUMN] as int),
      savedAt: DateTime.fromMillisecondsSinceEpoch(map[SAVED_AT_COLUMN] as int),
      isIncome: map[IS_INCOME_COLUMN] == 'true',
      price: map[PRICE_COLUMN] as double,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        account,
        isInstallment,
        numberOfInstallments,
        installmentId,
        isBetweenAccounts,
        betweenAccountsId,
        date,
        savedAt,
        isIncome,
        price,
      ];

  @override
  bool get stringify => true;
}
