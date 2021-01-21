part of 'filtered_transactions_bloc.dart';

abstract class FilteredTransactionsEvent extends Equatable {
  const FilteredTransactionsEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends FilteredTransactionsEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated(filter: $filter)';
}

class FilteredTransactionsUpdated extends FilteredTransactionsEvent {
  final List<UserTransaction> transactions;

  const FilteredTransactionsUpdated(this.transactions);

  @override
  List<Object> get props => [transactions];

  @override
  String toString() =>
      'FilteredTransactionsUpdated(transactions: $transactions)';
}
