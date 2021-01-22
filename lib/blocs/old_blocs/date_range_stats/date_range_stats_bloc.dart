import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/global_stats_repository.dart';

part 'date_range_stats_event.dart';
part 'date_range_stats_state.dart';

class DateRangeStatsBloc
    extends Bloc<DateRangeStatsEvent, DateRangeStatsState> {
  DateRangeStatsBloc() : super(DateRangeStatsLoadInProgress());

  final globalStatsRepository = GlobalStatsRepository();

  @override
  Stream<DateRangeStatsState> mapEventToState(
    DateRangeStatsEvent event,
  ) async* {
    if (event is DateRangeStatsUpdated) {
      final Map<String, dynamic> dateRangeBalance =
          await globalStatsRepository.getBalanceByDateRange(
        event.dateRange,
      );
      yield DateRangeStatsLoadSuccess(
          totalIncome: dateRangeBalance['totalIncome'] as double,
          totalOutcome: dateRangeBalance['totalOutcome'] as double,
          highestIncome: dateRangeBalance['highestIncome'] == null
              ? null
              : dateRangeBalance['highestIncome'] as UserTransaction,
          highestOutcome: dateRangeBalance['highestOutcome'] == null
              ? null
              : dateRangeBalance['highestOutcome'] as UserTransaction);
    }
  }
}
