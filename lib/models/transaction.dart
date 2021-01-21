import 'package:equatable/equatable.dart';
import 'package:personal_expenses/constants/transaction_table_constants.dart';

class UserTransaction extends Equatable {
  int? id;
  String title;
  String account;
  DateTime date;
  DateTime savedAt;
  bool isIncome;
  double price;

  UserTransaction({
    this.id,
    required this.title,
    required this.account,
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
      date: DateTime.fromMillisecondsSinceEpoch(map[DATE_COLUMN] as int),
      savedAt: DateTime.fromMillisecondsSinceEpoch(map[SAVED_AT_COLUMN] as int),
      isIncome: map[IS_INCOME_COLUMN] == 'true',
      price: map[PRICE_COLUMN] as double,
    );
  }

  @override
  String toString() {
    return 'UserTransaction(id: $id, title: $title, accountId: $account, date: $date, savedAt: $savedAt, isIncome: $isIncome, price: $price)';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        account,
        date,
        savedAt,
        isIncome,
        price,
      ];
}
