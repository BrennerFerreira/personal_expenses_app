import 'package:personal_expenses/constants/transaction_table_constants.dart';
import 'package:personal_expenses/models/transaction.dart';

//ignore_for_file: avoid_redundant_argument_values

UserTransaction completeTransactionMock = UserTransaction(
  title: 'test',
  account: 'account',
  id: 1,
  installmentId: 'test',
  betweenAccountsId: 'test',
  isBetweenAccounts: true,
  isIncome: true,
  isInstallment: true,
  numberOfInstallments: 1,
  date: DateTime(2021),
  savedAt: DateTime(2021),
  price: 1.99,
);

UserTransaction completeTransactionWithNullFieldsMock = UserTransaction(
  title: 'test',
  account: 'account',
  id: 1,
  installmentId: null,
  betweenAccountsId: null,
  isBetweenAccounts: true,
  isIncome: true,
  isInstallment: true,
  numberOfInstallments: 1,
  date: DateTime(2021),
  savedAt: DateTime(2021),
  price: 1.99,
);

Map<String, dynamic> transactionMapMock = {
  TITLE_COLUMN: 'test',
  ACCOUNT_COLUMN: 'account',
  ID_COLUMN: 1,
  INSTALLMENT_ID_COLUMN: 'test',
  BETWEEN_ACCOUNTS_ID_COLUMN: 'test',
  IS_BETWEEN_ACCOUNTS_COLUMN: 'true',
  IS_INCOME_COLUMN: 'true',
  IS_INSTALLMENT_COLUMN: 'true',
  NUMBER_INSTALLMENTS_COLUMN: 1,
  DATE_COLUMN: DateTime(2021).millisecondsSinceEpoch,
  SAVED_AT_COLUMN: DateTime(2021).millisecondsSinceEpoch,
  PRICE_COLUMN: 1.99,
};

Map<String, dynamic> transactionWithNullFieldsMapMock = {
  TITLE_COLUMN: 'test',
  ACCOUNT_COLUMN: 'account',
  ID_COLUMN: 1,
  INSTALLMENT_ID_COLUMN: 'null',
  BETWEEN_ACCOUNTS_ID_COLUMN: 'null',
  IS_BETWEEN_ACCOUNTS_COLUMN: 'true',
  IS_INCOME_COLUMN: 'true',
  IS_INSTALLMENT_COLUMN: 'true',
  NUMBER_INSTALLMENTS_COLUMN: 1,
  DATE_COLUMN: DateTime(2021).millisecondsSinceEpoch,
  SAVED_AT_COLUMN: DateTime(2021).millisecondsSinceEpoch,
  PRICE_COLUMN: 1.99,
};
