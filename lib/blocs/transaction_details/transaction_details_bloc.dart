import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'transaction_details_event.dart';
part 'transaction_details_state.dart';

class TransactionDetailsBloc
    extends Bloc<TransactionDetailsEvent, TransactionDetailsState> {
  TransactionDetailsBloc() : super(TransactionDetailsInitial());

  final transactionRepository = TransactionRepository();

  @override
  Stream<TransactionDetailsState> mapEventToState(
    TransactionDetailsEvent event,
  ) async* {
    if (event is DeleteTransaction) {
      yield TransactionDetailsLoading();

      await transactionRepository.deleteTransaction(event.transaction.id!);

      yield TransactionDeleteSuccess();

      yield TransactionDetailsInitial();
    }
  }
}
