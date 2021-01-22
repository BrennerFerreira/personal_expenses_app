part of 'account_bloc.dart';

@immutable
abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountLoadInProgress extends AccountState {}

class AccountLoadAllSuccess extends AccountState {
  final List<String> accountList;

  const AccountLoadAllSuccess([this.accountList = const []]);

  @override
  List<Object> get props => [accountList];

  @override
  String toString() => 'AccountLoadSuccess(AccountList: $accountList)';
}

class AccountLoadFailure extends AccountState {}
