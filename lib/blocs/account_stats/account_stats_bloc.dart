import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/repositories/account/account_stats_repository.dart';

part 'account_stats_event.dart';
part 'account_stats_state.dart';

class AccountStatsBloc extends Bloc<AccountStatsEvent, AccountStatsState> {
  AccountStatsBloc() : super(AccountStatsLoadInProgress());

  final accountStatsRepository = AccountStatsRepository();

  @override
  Stream<AccountStatsState> mapEventToState(
    AccountStatsEvent event,
  ) async* {
    if (event is AccountStatsUpdated) {
      final balanceMap = await accountStatsRepository
          .lastThirtyDaysAccountBalance(event.account);
      yield AccountStatsLoadSuccess(
        totalBalance: balanceMap['totalBalance'] as double,
        lastThirtyDaysIncome: balanceMap['totalIncome'] as double,
        lastThirtyDaysOutcome: balanceMap['totalOutcome'] as double,
        account: event.account,
      );
    } else if (event is AccountStatsLoadAll) {
      yield AccountStatsLoadInProgress();
      final accountsBalanceMap =
          await accountStatsRepository.getAllAcountsBalance();
      yield AccountStatsLoadAllSuccess(
        accountsBalanceMap: accountsBalanceMap,
      );
    }
  }
}
