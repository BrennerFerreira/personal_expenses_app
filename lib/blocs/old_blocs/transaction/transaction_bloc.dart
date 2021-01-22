import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionLoadInProgress());
  final transactionRepository = TransactionRepository();

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is TransactionLoad) {
      yield TransactionLoadSuccess();
    } else if (event is TransactionAdded) {
      yield* _mapTransactionAddedToState(event);
    } else if (event is TransactionUpdated) {
      yield* _mapTransactionUpdatedToState(event);
    } else if (event is TransactionDeleted) {
      yield* _mapTransactionDeletedToState(event);
    }
  }

  Stream<TransactionState> _mapTransactionAddedToState(
      TransactionAdded event) async* {
    await transactionRepository.saveTransaction(event.transaction);

    yield TransactionLoadSuccess();
  }

  Stream<TransactionState> _mapTransactionUpdatedToState(
      TransactionUpdated event) async* {
    await transactionRepository.updateTransaction(event.transaction);

    yield TransactionLoadSuccess();
  }

  Stream<TransactionState> _mapTransactionDeletedToState(
      TransactionDeleted event) async* {
    await transactionRepository.deleteTransaction(event.transaction.id!);

    yield TransactionLoadSuccess();
  }
}
