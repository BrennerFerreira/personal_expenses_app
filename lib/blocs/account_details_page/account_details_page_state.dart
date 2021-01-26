part of 'account_details_page_bloc.dart';

abstract class AccountDetailsPageState extends Equatable {
  const AccountDetailsPageState();

  @override
  List<Object?> get props => [];
}

class AccountDetailsPageLoadInProgress extends AccountDetailsPageState {}

class AccountDetailsPageLoadSuccess extends AccountDetailsPageState {
  final double balance;
  final double income;
  final double outcome;
  final List<UserTransaction> transactionList;

  const AccountDetailsPageLoadSuccess({
    required this.balance,
    required this.income,
    required this.outcome,
    required this.transactionList,
  });

  @override
  List<Object?> get props => [
        balance,
        income,
        outcome,
        transactionList,
      ];

  @override
  String toString() {
    return 'AccountDetailsPageLoadSuccess(balance: $balance, income: $income, outcome: $outcome, transactionList: $transactionList)';
  }
}
