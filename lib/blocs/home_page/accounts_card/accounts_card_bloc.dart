import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/account/account_stats_repository.dart';

part 'accounts_card_event.dart';
part 'accounts_card_state.dart';

class AccountsCardBloc extends Bloc<AccountsCardEvent, AccountsCardState> {
  AccountsCardBloc() : super(AccountsCardLoadInProgress());

  final accountStatsRepository = AccountStatsRepository();

  @override
  Stream<AccountsCardState> mapEventToState(
    AccountsCardEvent event,
  ) async* {
    if (event is UpdateAccountsCard) {
      yield AccountsCardLoadInProgress();
      final List<Map<String, double>> accountsBalanceMap =
          await accountStatsRepository.getAllAcountsBalance();
      yield AccountsCardLoadSuccess(accountsBalanceMap);
    }
  }
}
