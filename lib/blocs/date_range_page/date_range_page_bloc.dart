import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/transaction.dart';
import '../../repositories/transactions/global_stats_repository.dart';
import '../../repositories/transactions/transactions_repository.dart';

part 'date_range_page_event.dart';
part 'date_range_page_state.dart';

class DateRangePageBloc extends Bloc<DateRangePageEvent, DateRangePageState> {
  DateRangePageBloc() : super(DateRangePageLoadInProgress());

  final globalStatsRepository = GlobalStatsRepository();
  final transactionRepository = TransactionRepository();

  @override
  Stream<DateRangePageState> mapEventToState(
    DateRangePageEvent event,
  ) async* {
    yield DateRangePageLoadInProgress();
    if (event is UpdateDateRangePage) {
      final Map<String, dynamic> balanceMap =
          await globalStatsRepository.getBalanceByDateRange(
        DateTimeRange(
          start: event.startDate,
          end: event.endDate,
        ),
      );
      final double income = balanceMap["totalIncome"] as double;
      final double outcome = balanceMap['totalOutcome'] as double;
      final UserTransaction? highestIncome = balanceMap['highestIncome'] == null
          ? null
          : balanceMap['highestIncome'] as UserTransaction;
      final UserTransaction? highestOutcome =
          balanceMap['highestOutcome'] == null
              ? null
              : balanceMap['highestOutcome'] as UserTransaction;
      final List<UserTransaction> transactionList =
          await transactionRepository.getTransactionByDateRange(
        DateTimeRange(
          start: event.startDate,
          end: event.endDate,
        ),
      );

      yield DateRangePageLoadSuccess(
        startDate: event.startDate,
        endDate: event.endDate,
        income: income,
        outcome: outcome,
        highestIncome: highestIncome,
        highestOutcome: highestOutcome,
        transactionList: transactionList,
      );
    }
  }
}
