part of 'date_range_page_bloc.dart';

abstract class DateRangePageEvent extends Equatable {
  const DateRangePageEvent();

  @override
  List<Object?> get props => [];
}

class UpdateDateRangePage extends DateRangePageEvent {
  final DateTime startDate;
  final DateTime endDate;
  const UpdateDateRangePage({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
      ];

  @override
  String toString() =>
      'UpdateDateRangePage(startDate: $startDate, endDate: $endDate)';
}
