part of 'global_stats_bloc.dart';

abstract class GlobalStatsState extends Equatable {
  const GlobalStatsState();

  @override
  List<Object> get props => [];
}

class GlobalStatsLoadInProgress extends GlobalStatsState {}

class GlobalStatsLoadSuccess extends GlobalStatsState {
  final double totalBalance;
  final double lastThirtyDaysIncome;
  final double lastThirtyDaysOutcome;

  const GlobalStatsLoadSuccess({
    required this.totalBalance,
    required this.lastThirtyDaysIncome,
    required this.lastThirtyDaysOutcome,
  });

  @override
  List<Object> get props => [
        totalBalance,
        lastThirtyDaysIncome,
        lastThirtyDaysOutcome,
      ];

  @override
  String toString() =>
      'GlobalStatsLoadSuccess(totalBalance: $totalBalance, lastThirtyDaysIncome: $lastThirtyDaysIncome, lastThirtyDaysOutcome: $lastThirtyDaysOutcome)';
}
