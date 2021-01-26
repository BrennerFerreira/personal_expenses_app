part of 'future_transactions_page_bloc.dart';

abstract class FutureTransactionsPageState extends Equatable {
  const FutureTransactionsPageState();

  @override
  List<Object?> get props => [];
}

class FutureTransactionsPageLoadInProgress extends FutureTransactionsPageState {
}

class FutureTransactionsPageLoadSuccess extends FutureTransactionsPageState {
  final double income;
  final double outcome;
  final UserTransaction? highestIncome;
  final UserTransaction? highestOutcome;
  final List<UserTransaction> transactionList;
  const FutureTransactionsPageLoadSuccess({
    required this.income,
    required this.outcome,
    this.highestIncome,
    this.highestOutcome,
    required this.transactionList,
  });

  @override
  List<Object?> get props => [
        income,
        outcome,
        highestIncome,
        highestOutcome,
        transactionList,
      ];

  @override
  String toString() {
    return 'FutureTransactionsPageLoadSuccess(income: $income, outcome: $outcome, highestIncome: $highestIncome, highestOutcome: $highestOutcome, transactionList: $transactionList)';
  }
}
