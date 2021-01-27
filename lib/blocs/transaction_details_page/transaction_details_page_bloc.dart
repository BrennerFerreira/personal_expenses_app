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
    if (event is UpdateTransactionDetailsPage) {
      yield const TransactionDetailsState();
      {
        if (event.transaction.isBetweenAccounts) {
          final Map<String, UserTransaction> betweenAccountsMap =
              await transactionRepository.getBetweenAccountsTransaction(
            event.transaction.betweenAccountsId!,
          );
          final UserTransaction origin =
              betweenAccountsMap['outcome'] as UserTransaction;
          final UserTransaction destination =
              betweenAccountsMap['income'] as UserTransaction;
          yield state.copyWith(
            isLoading: false,
            originTransaction: origin,
            destinationTransaction: destination,
          );
        } else {
          yield state.copyWith(
            isLoading: false,
            originTransaction: event.transaction,
          );
        }
      }
    }
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
