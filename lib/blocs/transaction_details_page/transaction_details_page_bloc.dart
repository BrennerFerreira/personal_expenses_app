import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'transaction_details_page_event.dart';
part 'transaction_details_page_state.dart';

class TransactionDetailsBloc
    extends Bloc<TransactionDetailsEvent, TransactionDetailsState> {
  TransactionDetailsBloc() : super(const TransactionDetailsState());

  final transactionRepository = TransactionRepository();

  @override
  Stream<TransactionDetailsState> mapEventToState(
    TransactionDetailsEvent event,
  ) async* {
    if (event is DeleteTransaction) {
      yield state.copyWith(
        isLoading: true,
      );
      if (event.transaction.isBetweenAccounts) {
        await transactionRepository.deleteTransactionByBetweenAccounId(
          event.transaction.betweenAccountsId!,
        );
      } else {
        if (state.deleteAllInstallments) {
          await transactionRepository.deleteTransactionByInstallmentId(
            event.transaction.installmentId!,
          );
        } else {
          await transactionRepository.deleteTransaction(event.transaction.id!);
        }
      }

      yield TransactionDeleteSuccess();

      yield const TransactionDetailsState();
    } else if (event is DeleteAllInstallmentsChanged) {
      yield state.copyWith(
        deleteAllInstallments: event.newDeleteAllTransactions,
      );
    }
  }
}
