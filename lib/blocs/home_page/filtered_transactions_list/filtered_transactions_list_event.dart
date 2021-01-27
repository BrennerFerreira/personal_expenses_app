part of 'filtered_transactions_list_bloc.dart';

abstract class FilteredTransactionsListEvent extends Equatable {
  const FilteredTransactionsListEvent();

  @override
  List<Object?> get props => [];
}

class FilterUpdated extends FilteredTransactionsListEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object?> get props => [filter];

  @override
  String toString() => 'FilterUpdated(filter: $filter)';
}
