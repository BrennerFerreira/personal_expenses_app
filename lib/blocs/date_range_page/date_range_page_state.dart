part of 'date_range_page_bloc.dart';

abstract class DateRangePageState extends Equatable {
  const DateRangePageState();

  @override
  List<Object?> get props => [];
}

class DateRangePageLoadInProgress extends DateRangePageState {}

class DateRangePageLoadSuccess extends DateRangePageState {
  final DateTime startDate;
  final DateTime endDate;
  final double income;
  final double outcome;
  final UserTransaction? highestIncome;
  final UserTransaction? highestOutcome;
  final List<UserTransaction> transactionList;
  const DateRangePageLoadSuccess({
    required this.startDate,
    required this.endDate,
    required this.income,
    required this.outcome,
    this.highestIncome,
    this.highestOutcome,
    required this.transactionList,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        income,
        outcome,
        highestIncome,
        highestOutcome,
        transactionList,
      ];

  @override
  String toString() {
    return 'DateRangePageLoadSucess(startDate: $startDate, endDate: $endDate, income: $income, outcome: $outcome, highestIncome: $highestIncome, highestOutcome: $highestOutcome, transactionList: $transactionList)';
  }
}
