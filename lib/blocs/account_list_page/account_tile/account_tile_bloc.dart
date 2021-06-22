import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/account/account_stats_repository.dart';

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

      final Map<String, double> accountBalance =
          await accountStatsRepository.accountBalance(event.account);

      yield AccountTileLoadSuccess(
        account: event.account,
        income: accountBalance["totalIncome"]!,
        outcome: accountBalance["totalOutcome"]!,
        balance: accountBalance["totalBalance"]!,
      );
    }
  }
}
