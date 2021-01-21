part of 'date_range_stats_bloc.dart';

abstract class DateRangeStatsState extends Equatable {
  const DateRangeStatsState();

  @override
  List<Object> get props => [];
}

class DateRangeStatsLoadInProgress extends DateRangeStatsState {}

class DateRangeStatsLoadSuccess extends DateRangeStatsState {
  final double totalIncome;
  final double totalOutcome;
  final UserTransaction? highestIncome;
  final UserTransaction? highestOutcome;

  const DateRangeStatsLoadSuccess({
    required this.totalIncome,
    required this.totalOutcome,
    required this.highestIncome,
    required this.highestOutcome,
  });

  @override
  List<Object> get props => [
        totalIncome,
        totalOutcome,
      ];

  @override
  String toString() {
    return 'DateRangeStatsLoadSuccess(totalIncome: $totalIncome, totalOutcome: $totalOutcome, highestIncome: $highestIncome, highestOutcome: $highestOutcome)';
  }
}
