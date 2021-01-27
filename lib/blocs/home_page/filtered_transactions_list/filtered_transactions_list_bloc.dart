import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/models/visibility_filter.dart';
import 'package:personal_expenses/repositories/future_transactions/future_transactions_repository.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'filtered_transactions_list_event.dart';
part 'filtered_transactions_list_state.dart';

class FilteredTransactionsListBloc
    extends Bloc<FilteredTransactionsListEvent, FilteredTransactionsListState> {
  FilteredTransactionsListBloc()
      : super(FilteredTransactionsListLoadInProgress()) {
    add(const FilterUpdated(VisibilityFilter.lastSevenDays));
  }

  final transactionRepository = TransactionRepository();
  final futureTransactionsRepository = FutureTransactionsRepository();

  @override
  Stream<FilteredTransactionsListState> mapEventToState(
    FilteredTransactionsListEvent event,
  ) async* {
    if (event is FilterUpdated) {
      final List<UserTransaction> transactionList =
          await _mapTransactionsToFilter(event.filter);
      yield FilteredTransactionsListLoadSuccess(
        filteredTransactions: transactionList,
        activeFilter: event.filter,
      );
    }
  }

  Future<List<UserTransaction>> _mapTransactionsToFilter(
      VisibilityFilter filter) async {
    if (filter == VisibilityFilter.all) {
      return transactionRepository.getAllTransactions();
    } else if (filter == VisibilityFilter.lastSevenDays) {
      return transactionRepository.getAllTransactionsLimitedByDate(7);
    } else if (filter == VisibilityFilter.lastThirtyDays) {
      return transactionRepository.getAllTransactionsLimitedByDate(30);
    } else if (filter == VisibilityFilter.future) {
      return futureTransactionsRepository.getAllFutureTransactions();
    } else {
      return transactionRepository.getAllTransactions();
    }
  }
}
