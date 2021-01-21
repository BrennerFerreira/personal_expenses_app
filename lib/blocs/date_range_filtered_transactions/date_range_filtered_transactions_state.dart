part of 'date_range_filtered_transactions_bloc.dart';

abstract class DateRangeFilteredTransactionsState extends Equatable {
  const DateRangeFilteredTransactionsState();

  @override
  List<Object> get props => [];
}

class DateRangeFilteredTransactionsLoadInProgress
    extends DateRangeFilteredTransactionsState {}

class DateRangeFilteredTransactionsLoadSuccess
    extends DateRangeFilteredTransactionsState {
  final List<UserTransaction> transactionList;

  const DateRangeFilteredTransactionsLoadSuccess(this.transactionList);

  @override
  List<Object> get props => [transactionList];

  @override
  String toString() =>
      'DateRangeFilteredTransactionsLoadSuccess(transactionList: $transactionList)';
}
