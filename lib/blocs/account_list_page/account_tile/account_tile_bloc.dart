import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/repositories/account/account_stats_repository.dart';

part 'account_tile_event.dart';
part 'account_tile_state.dart';

class AccountTileBloc extends Bloc<AccountTileEvent, AccountTileState> {
  AccountTileBloc() : super(AccountTileLoadInProgress());

  final accountStatsRepository = AccountStatsRepository();

  @override
  Stream<AccountTileState> mapEventToState(
    AccountTileEvent event,
  ) async* {
    if (event is UpdateAccountTile) {
      yield AccountTileLoadInProgress();

      final Map<String, double> accountBalance = await accountStatsRepository
          .lastThirtyDaysAccountBalance(event.account);

      yield AccountTileLoadSuccess(
        account: event.account,
        income: accountBalance["totalIncome"] as double,
        outcome: accountBalance["totalOutcome"] as double,
        balance: accountBalance["totalBalance"] as double,
      );
    }
  }
}
