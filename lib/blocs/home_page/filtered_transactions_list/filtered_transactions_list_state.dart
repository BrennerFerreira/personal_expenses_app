part of 'filtered_transactions_list_bloc.dart';

abstract class FilteredTransactionsListState extends Equatable {
  const FilteredTransactionsListState();

  @override
  List<Object?> get props => [];
}

class FilteredTransactionsListLoadInProgress
    extends FilteredTransactionsListState {}

class FilteredTransactionsListLoadSuccess
    extends FilteredTransactionsListState {
  final List<UserTransaction> filteredTransactions;
  final VisibilityFilter activeFilter;
  const FilteredTransactionsListLoadSuccess({
    required this.filteredTransactions,
    required this.activeFilter,
  });

  @override
  List<Object?> get props => [filteredTransactions, activeFilter];

  @override
  String toString() =>
      'FilteredTransactionsLoadSuccess(filteredTransactions: $filteredTransactions, activeFilter: $activeFilter)';
}
