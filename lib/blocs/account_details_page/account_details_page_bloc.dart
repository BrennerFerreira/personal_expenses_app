import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/transaction.dart';
import '../../repositories/account/account_repository.dart';
import '../../repositories/account/account_stats_repository.dart';

part 'account_details_page_event.dart';
part 'account_details_page_state.dart';

class AccountDetailsPageBloc
    extends Bloc<AccountDetailsPageEvent, AccountDetailsPageState> {
  AccountDetailsPageBloc() : super(AccountDetailsPageLoadInProgress());

  final accountStatsRepository = AccountStatsRepository();
  final accountRepository = AccountRepository();

  @override
  Stream<AccountDetailsPageState> mapEventToState(
    AccountDetailsPageEvent event,
  ) async* {
    if (event is UpdateAccountDetailsPage) {
      yield AccountDetailsPageLoadInProgress();

      final Map<String, double> accountBalanceMap =
          await accountStatsRepository.accountBalance(event.account);
      final double balance = accountBalanceMap["totalBalance"]!;
      final double income = accountBalanceMap["totalIncome"]!;
      final double outcome = accountBalanceMap["totalOutcome"]!;

      final List<UserTransaction> transactionList =
          await accountRepository.getAllTransactionsByAccount(event.account);

      yield AccountDetailsPageLoadSuccess(
        balance: balance,
        income: income,
        outcome: outcome,
        transactionList: transactionList,
      );
    }
  }
}
