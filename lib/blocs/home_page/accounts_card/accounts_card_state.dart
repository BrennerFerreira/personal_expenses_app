part of 'accounts_card_bloc.dart';

abstract class AccountsCardState extends Equatable {
  const AccountsCardState();

  @override
  List<Object?> get props => [];
}

class AccountsCardLoadInProgress extends AccountsCardState {}

class AccountsCardLoadSuccess extends AccountsCardState {
  final List<Map<String, double>> accountsBalanceMap;

  const AccountsCardLoadSuccess(this.accountsBalanceMap);

  @override
  List<Object?> get props => [accountsBalanceMap];

  @override
  String toString() =>
      'AccountsCardLoadSuccess(accountsBalanceMap: $accountsBalanceMap)';
}
