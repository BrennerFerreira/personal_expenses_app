part of 'account_tile_bloc.dart';

abstract class AccountTileState extends Equatable {
  const AccountTileState();

  @override
  List<Object?> get props => [];
}

class AccountTileLoadInProgress extends AccountTileState {}

class AccountTileLoadSuccess extends AccountTileState {
  final String account;
  final double income;
  final double outcome;
  final double balance;

  const AccountTileLoadSuccess({
    required this.account,
    required this.income,
    required this.outcome,
    required this.balance,
  });

  @override
  List<Object?> get props => [
        account,
        income,
        outcome,
        balance,
      ];

  @override
  String toString() {
    return 'AccountTileLoadSuccess(account: $account, income: $income, outcome: $outcome, balance: $balance)';
  }
}
