part of 'future_transactions_stats_bloc.dart';

abstract class FutureTransactionsStatsState extends Equatable {
  const FutureTransactionsStatsState();

  @override
  List<Object> get props => [];
}

class FutureTransactionsStatsLoadInProgress
    extends FutureTransactionsStatsState {}

class FutureTransactionsStatsLoadSuccess extends FutureTransactionsStatsState {
  final double totalIncome;
  final double totalOutcome;
  final UserTransaction? higherIncome;
  final UserTransaction? higherOutcome;

  const FutureTransactionsStatsLoadSuccess({
    required this.totalIncome,
    required this.totalOutcome,
    required this.higherIncome,
    required this.higherOutcome,
  });

  @override
  List<Object> get props => [
        totalIncome,
        totalOutcome,
      ];

  @override
  String toString() {
    return 'FutureTransactionsStatsLoadSuccess(totalIncome: $totalIncome, totalOutcome: $totalOutcome, higherIncome: $higherIncome, higherOutcome: $higherOutcome)';
  }
}
