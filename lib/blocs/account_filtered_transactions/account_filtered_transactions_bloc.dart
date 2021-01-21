import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/account/account_repository.dart';

part 'account_filtered_transactions_event.dart';
part 'account_filtered_transactions_state.dart';

class AccountFilteredTransactionsBloc extends Bloc<
    AccountFilteredTransactionsEvent, AccountFilteredTransactionsState> {
  AccountFilteredTransactionsBloc()
      : super(AccountFilteredTransactionsLoadInProgress());

  final accountRepository = AccountRepository();

  @override
  Stream<AccountFilteredTransactionsState> mapEventToState(
    AccountFilteredTransactionsEvent event,
  ) async* {
    if (event is AccountFilterUpdated) {
      final List<UserTransaction> transactionList =
          await accountRepository.getAllTransactionsByAccount(event.account);
      yield AccountFilteredTransactionsLoadSuccess(
        accountFilteredTransactions: transactionList,
      );
    }
  }
}
