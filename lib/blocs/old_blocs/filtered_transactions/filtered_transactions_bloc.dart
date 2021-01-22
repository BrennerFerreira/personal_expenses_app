import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/models/visibility_filter.dart';
import 'package:personal_expenses/repositories/future_transactions/future_transactions_repository.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'filtered_transactions_event.dart';
part 'filtered_transactions_state.dart';

class FilteredTransactionsBloc
    extends Bloc<FilteredTransactionsEvent, FilteredTransactionsState> {
  FilteredTransactionsBloc() : super(FilteredTransactionsLoadInProgress());

  final transactionRepository = TransactionRepository();
  final futureTransactionsRepository = FutureTransactionsRepository();

  @override
  Stream<FilteredTransactionsState> mapEventToState(
    FilteredTransactionsEvent event,
  ) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is FilteredTransactionsUpdated) {
      yield* _mapFilteredTransactionsUpdatedToState(event);
    }
  }

  Stream<FilteredTransactionsState> _mapUpdateFilterToState(
      FilterUpdated event) async* {
    final List<UserTransaction> transactionList =
        await _mapTransactionsToFilter(event.filter);
    yield FilteredTransactionsLoadSuccess(
      filteredTransactions: transactionList,
      activeFilter: event.filter,
    );
  }

  Stream<FilteredTransactionsState> _mapFilteredTransactionsUpdatedToState(
      FilteredTransactionsEvent event) async* {
    final visibilityFilter =
        (state as FilteredTransactionsLoadSuccess).activeFilter;
    final List<UserTransaction> transactionList =
        await _mapTransactionsToFilter(visibilityFilter);
    yield FilteredTransactionsLoadSuccess(
      filteredTransactions: transactionList,
      activeFilter: visibilityFilter,
    );
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
