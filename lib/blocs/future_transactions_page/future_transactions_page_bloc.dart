import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/transaction.dart';
import '../../repositories/future_transactions/future_transactions_repository.dart';
import '../../repositories/future_transactions/future_transactions_stats_repository.dart';

part 'future_transactions_page_event.dart';
part 'future_transactions_page_state.dart';

class FutureTransactionsPageBloc
    extends Bloc<FutureTransactionsPageEvent, FutureTransactionsPageState> {
  FutureTransactionsPageBloc() : super(FutureTransactionsPageLoadInProgress());

  final futureTransactionsRepository = FutureTransactionsRepository();
  final futureTransactionsStatsRepository = FutureTransactionsStatsRepository();

  @override
  Stream<FutureTransactionsPageState> mapEventToState(
    FutureTransactionsPageEvent event,
  ) async* {
    if (event is UpdateFutureTransactionsPage) {
      yield FutureTransactionsPageLoadInProgress();
      final Map<String, dynamic> balanceMap =
          await futureTransactionsStatsRepository.futureBalance();
      final double income = balanceMap["totalIncome"] as double;
      final double outcome = balanceMap["totalOutcome"] as double;
      final UserTransaction? highestIncome = balanceMap["highestIncome"] == null
          ? null
          : balanceMap["highestIncome"] as UserTransaction;
      final UserTransaction? highestOutcome =
          balanceMap["highestOutcome"] == null
              ? null
              : balanceMap["highestOutcome"] as UserTransaction;

      final List<UserTransaction> transactionList =
          await futureTransactionsRepository.getAllFutureTransactions();

      yield FutureTransactionsPageLoadSuccess(
        income: income,
        outcome: outcome,
        highestIncome: highestIncome,
        highestOutcome: highestOutcome,
        transactionList: transactionList,
      );
    }
  }
}
