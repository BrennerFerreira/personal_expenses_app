import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/repositories/transactions/global_stats_repository.dart';

part 'date_range_transactions_card_event.dart';
part 'date_range_transactions_card_state.dart';

class DateRangeTransactionsCardBloc extends Bloc<DateRangeTransactionsCardEvent,
    DateRangeTransactionsCardState> {
  DateRangeTransactionsCardBloc()
      : super(DateRangeTransactionsCardLoadInProgress());

  final globalStatsRepository = GlobalStatsRepository();

  @override
  Stream<DateRangeTransactionsCardState> mapEventToState(
    DateRangeTransactionsCardEvent event,
  ) async* {
    if (event is UpdateDateRangeTransactionsCard) {
      final Map<String, dynamic> balanceMap =
          await globalStatsRepository.getBalanceByDateRange(
        DateTimeRange(
          start: DateTime(
            DateTime.now().year,
            DateTime.now().month,
          ),
          end: DateTime(
            DateTime.now().year,
            DateTime.now().month + 1,
            0,
          ),
        ),
      );
      final double income = balanceMap["totalIncome"] as double;
      final double outcome = balanceMap["totalOutcome"] as double;
      final double balance = income - outcome;

      yield DateRangeTransactionsCardLoadSuccess(
        income: income,
        outcome: outcome,
        balance: balance,
      );
    }
  }
}
