part of 'date_range_filtered_transactions_bloc.dart';

abstract class DateRangeFilteredTransactionsEvent extends Equatable {
  const DateRangeFilteredTransactionsEvent();

  @override
  List<Object> get props => [];
}

class DateRangeFilterUpdate extends DateRangeFilteredTransactionsEvent {
  final DateTimeRange dateRange;
  const DateRangeFilterUpdate({
    required this.dateRange,
  });

  @override
  List<Object> get props => [dateRange];

  @override
  String toString() => 'DateRangeFilterUpdate(dateRange: $dateRange)';
}
