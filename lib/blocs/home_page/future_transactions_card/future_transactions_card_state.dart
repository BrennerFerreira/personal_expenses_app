part of 'future_transactions_card_bloc.dart';

abstract class FutureTransactionsCardState extends Equatable {
  const FutureTransactionsCardState();

  @override
  List<Object?> get props => [];
}

class FutureTransactionsCardLoadInProgress extends FutureTransactionsCardState {
}

class FutureTransactionsCardLoadSuccess extends FutureTransactionsCardState {
  final double income;
  final double outcome;
  final UserTransaction? nextTransaction;

  const FutureTransactionsCardLoadSuccess({
    required this.income,
    required this.outcome,
    this.nextTransaction,
  });

  @override
  List<Object?> get props => [
        income,
        outcome,
        nextTransaction,
      ];

  @override
  String toString() =>
      'FutureTransactionsCardLoadSuccess(income: $income, outcome: $outcome, nextTransaction: $nextTransaction)';
}
