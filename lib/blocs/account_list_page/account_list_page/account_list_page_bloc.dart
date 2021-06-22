import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/account/account_repository.dart';

part 'account_list_page_event.dart';
part 'account_list_page_state.dart';

class AccountListPageBloc
    extends Bloc<AccountListPageEvent, AccountListPageState> {
  AccountListPageBloc() : super(AccountListPageLoadInProgress());

  final accountRepository = AccountRepository();

  @override
  Stream<AccountListPageState> mapEventToState(
    AccountListPageEvent event,
  ) async* {
    if (event is UpdateAccountList) {
      yield AccountListPageLoadInProgress();

      final List<String> accountList = await accountRepository.getAllAccounts();

      yield AccountListPageLoadSuccess(
        accountList: accountList,
      );
    }
  }
}
