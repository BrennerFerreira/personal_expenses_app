import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'date_range_filtered_transactions_event.dart';
part 'date_range_filtered_transactions_state.dart';

class DateRangeFilteredTransactionsBloc extends Bloc<
    DateRangeFilteredTransactionsEvent, DateRangeFilteredTransactionsState> {
  DateRangeFilteredTransactionsBloc()
      : super(DateRangeFilteredTransactionsLoadInProgress());

  final transactionRepository = TransactionRepository();

  @override
  Stream<DateRangeFilteredTransactionsState> mapEventToState(
    DateRangeFilteredTransactionsEvent event,
  ) async* {
    if (event is DateRangeFilterUpdate) {
      final List<UserTransaction> transactionList =
          await transactionRepository.getTransactionByDateRange(
        event.dateRange,
      );
      yield DateRangeFilteredTransactionsLoadSuccess(transactionList);
    }
  }
}
