import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:personal_expenses/repositories/account/account_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoadInProgress());
  final accountRepository = AccountRepository();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    yield* _mapAccountLoadedToState(event);
  }

  Stream<AccountState> _mapAccountLoadedToState(AccountEvent event) async* {
    if (event is AccountLoadAll) {
      try {
        final accounts = await accountRepository.getAllAccounts();
        yield AccountLoadAllSuccess(accounts);
      } catch (_) {
        yield AccountLoadFailure();
      }
    }
  }
}
