part of 'filtered_transactions_bloc.dart';

abstract class FilteredTransactionsState extends Equatable {
  const FilteredTransactionsState();

  @override
  List<Object> get props => [];
}

class FilteredTransactionsLoadInProgress extends FilteredTransactionsState {}

class FilteredTransactionsLoadSuccess extends FilteredTransactionsState {
  final List<UserTransaction> filteredTransactions;
  final VisibilityFilter activeFilter;
  const FilteredTransactionsLoadSuccess({
    required this.filteredTransactions,
    required this.activeFilter,
  });

  @override
  List<Object> get props => [filteredTransactions, activeFilter];

  @override
  String toString() =>
      'FilteredTransactionsLoadSuccess(filteredTransactions: $filteredTransactions, activeFilter: $activeFilter)';
}
