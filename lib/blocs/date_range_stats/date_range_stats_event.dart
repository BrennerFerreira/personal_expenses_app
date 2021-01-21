part of 'date_range_stats_bloc.dart';

abstract class DateRangeStatsEvent extends Equatable {
  const DateRangeStatsEvent();

  @override
  List<Object> get props => [];
}

class DateRangeStatsUpdated extends DateRangeStatsEvent {
  final DateTimeRange dateRange;

  const DateRangeStatsUpdated(this.dateRange);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DateRangeStatsUpdated(dateRange: $dateRange)';
}
