part of 'date_range_transactions_card_bloc.dart';

abstract class DateRangeTransactionsCardState extends Equatable {
  const DateRangeTransactionsCardState();

  @override
  List<Object?> get props => [];
}

class DateRangeTransactionsCardLoadInProgress
    extends DateRangeTransactionsCardState {}

class DateRangeTransactionsCardLoadSuccess
    extends DateRangeTransactionsCardState {
  final double income;
  final double outcome;
  final double balance;

  const DateRangeTransactionsCardLoadSuccess({
    required this.income,
    required this.outcome,
    required this.balance,
  });

  @override
  List<Object?> get props => [
        income,
        outcome,
        balance,
      ];

  @override
  String toString() =>
      'DateRangeTransactionsCardLoadSuccess(income: $income, outcome: $outcome, balance: $balance)';
}
