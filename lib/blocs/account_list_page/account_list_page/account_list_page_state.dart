part of 'account_list_page_bloc.dart';

abstract class AccountListPageState extends Equatable {
  const AccountListPageState();

  @override
  List<Object?> get props => [];
}

class AccountListPageLoadInProgress extends AccountListPageState {}

class AccountListPageLoadSuccess extends AccountListPageState {
  final List<String> accountList;

  const AccountListPageLoadSuccess({
    required this.accountList,
  });

  @override
  List<Object?> get props => [accountList];

  @override
  String toString() => 'AccountListPageLoadSuccess(accountList: $accountList)';
}
