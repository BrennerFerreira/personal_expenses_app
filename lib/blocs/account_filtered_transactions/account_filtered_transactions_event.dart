part of 'account_filtered_transactions_bloc.dart';

abstract class AccountFilteredTransactionsEvent extends Equatable {
  const AccountFilteredTransactionsEvent();

  @override
  List<Object> get props => [];
}

class AccountFilterUpdated extends AccountFilteredTransactionsEvent {
  final String account;

  const AccountFilterUpdated(this.account);

  @override
  List<Object> get props => [account];

  @override
  String toString() => 'FilterUpdated(account: $account)';
}
