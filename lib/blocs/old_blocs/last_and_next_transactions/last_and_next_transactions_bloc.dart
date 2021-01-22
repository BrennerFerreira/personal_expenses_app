import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'last_and_next_transactions_event.dart';
part 'last_and_next_transactions_state.dart';

class LastAndNextTransactionsBloc
    extends Bloc<LastAndNextTransactionsEvent, LastAndNextTransactionsState> {
  LastAndNextTransactionsBloc()
      : super(LastAndNextTransactionsLoadInProgress());

  final transactionRepository = TransactionRepository();

  @override
  Stream<LastAndNextTransactionsState> mapEventToState(
    LastAndNextTransactionsEvent event,
  ) async* {
    if (event is LastAndNextTransactionLoad) {
      yield LastAndNextTransactionsLoadInProgress();
      final UserTransaction? lastTransaction =
          await transactionRepository.getLastTransaction();
      final UserTransaction? nextTransaction =
          await transactionRepository.getNextTransaction();
      yield LastAndNextTransactionsLoadSuccess(
        lastTransaction: lastTransaction,
        nextTransaction: nextTransaction,
      );
    }
  }
}
