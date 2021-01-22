import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc
    extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc() : super(const TransactionFormInitial());

  @override
  Stream<TransactionFormState> mapEventToState(
    TransactionFormEvent event,
  ) async* {
    if (event is TitleChanged) {
      yield state.copyWith(
        title: event.newTitle,
      );
    } else if (event is FormSubmitted) {
      if (state.title.trim().isEmpty) {
        yield const TransactionFormError(
          titleError: "Erro",
        );
      }
    }
  }
}
