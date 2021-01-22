part of 'account_filtered_transactions_bloc.dart';

abstract class AccountFilteredTransactionsState extends Equatable {
  const AccountFilteredTransactionsState();

  @override
  List<Object> get props => [];
}

class AccountFilteredTransactionsLoadInProgress
    extends AccountFilteredTransactionsState {}

class AccountFilteredTransactionsLoadSuccess
    extends AccountFilteredTransactionsState {
  final List<UserTransaction> accountFilteredTransactions;

  const AccountFilteredTransactionsLoadSuccess({
    required this.accountFilteredTransactions,
  });

  @override
  List<Object> get props => [accountFilteredTransactions];

  @override
  String toString() =>
      'FilteredTransactionsLoadSuccess(filteredTransactions: $accountFilteredTransactions)';
}
