import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/transaction.dart';
import '../../../repositories/future_transactions/future_transactions_stats_repository.dart';
import '../../../repositories/transactions/transactions_repository.dart';

part 'future_transactions_card_event.dart';
part 'future_transactions_card_state.dart';

class FutureTransactionsCardBloc
    extends Bloc<FutureTransactionsCardEvent, FutureTransactionsCardState> {
  FutureTransactionsCardBloc() : super(FutureTransactionsCardLoadInProgress());

  final futureTransactionsStatsRepository = FutureTransactionsStatsRepository();
  final transactionsRepository = TransactionRepository();

  @override
  Stream<FutureTransactionsCardState> mapEventToState(
    FutureTransactionsCardEvent event,
  ) async* {
    if (event is UpdateFutureTransactionsCard) {
      final Map<String, dynamic> futureBalanceMap =
          await futureTransactionsStatsRepository.futureBalance();
      final double income = futureBalanceMap['totalIncome'] as double;
      final double outcome = futureBalanceMap['totalOutcome'] as double;
      final UserTransaction? nextTransaction =
          await transactionsRepository.getNextTransaction();

      yield FutureTransactionsCardLoadSuccess(
        income: income,
        outcome: outcome,
        nextTransaction: nextTransaction,
      );
    }
  }
}
