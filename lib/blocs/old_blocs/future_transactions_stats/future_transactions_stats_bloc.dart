import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/future_transactions/future_transactions_stats_repository.dart';

part 'future_transactions_stats_event.dart';
part 'future_transactions_stats_state.dart';

class FutureTransactionsStatsBloc
    extends Bloc<FutureTransactionsStatsEvent, FutureTransactionsStatsState> {
  FutureTransactionsStatsBloc()
      : super(FutureTransactionsStatsLoadInProgress());
  final futureTransactionsStatsRepository = FutureTransactionsStatsRepository();

  @override
  Stream<FutureTransactionsStatsState> mapEventToState(
    FutureTransactionsStatsEvent event,
  ) async* {
    if (event is FutureTransactionsStatsUpdated) {
      final futureTransactionsMap =
          await futureTransactionsStatsRepository.futureBalance();
      yield FutureTransactionsStatsLoadSuccess(
        totalIncome: futureTransactionsMap['totalIncome'] as double,
        totalOutcome: futureTransactionsMap['totalOutcome'] as double,
        higherIncome: futureTransactionsMap['highestIncome'] == null
            ? null
            : futureTransactionsMap['highestIncome'] as UserTransaction,
        higherOutcome: futureTransactionsMap['highestOutcome'] == null
            ? null
            : futureTransactionsMap['highestOutcome'] as UserTransaction,
      );
    }
  }
}
