import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/account/account_repository.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc
    extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc() : super(const TransactionFormLoadInProgress());

  final accountRepository = AccountRepository();

  @override
  Stream<TransactionFormState> mapEventToState(
    TransactionFormEvent event,
  ) async* {
    if (event is AddTransaction) {
      yield const TransactionFormLoadInProgress();
      final List<String> accountList = await accountRepository.getAllAccounts();
      yield TransactionFormState(
        accountList: accountList,
      );
    } else if (event is EditTransaction) {
      yield const TransactionFormLoadInProgress();
      final List<String> accountList = await accountRepository.getAllAccounts();
      yield TransactionFormState(
        accountList: accountList,
        account: event.transaction.account,
        title: event.transaction.title,
      );
    } else if (event is TitleChanged) {
      yield state.copyWith(
        title: event.newTitle,
      );
    } else if (event is InvertNewAccountValue) {
      yield state.copyWith(
        newAccount: event.newOption,
        account: "",
      );
    } else if (event is AccountChanged) {
      yield state.copyWith(
        account: event.newAccount,
      );
    } else if (event is PriceChanged) {
      final String priceReplaced = event.newPrice.replaceAll(",", ".");
      final double price = double.parse(priceReplaced);
      yield state.copyWith(
        price: price,
      );
    } else if (event is FormSubmitted) {
      String? titleError;
      String? accountError;
      String? priceError;
      if (state.title.trim().isEmpty) {
        titleError = "Por favor, escreva um título válido para a transação.";
      }
      if (state.account.trim().isEmpty) {
        accountError = "Por favor, selecione uma conta para a transação.";
      }

      if (state.price <= 0.0) {
        priceError = "Por favor, selecione um valor para a transação.";
      }
      if (titleError != null || accountError != null || priceError != null) {
        yield TransactionFormError(
          titleError: titleError,
          accountError: accountError,
          priceError: priceError,
        );
      }
    }
  }
}
