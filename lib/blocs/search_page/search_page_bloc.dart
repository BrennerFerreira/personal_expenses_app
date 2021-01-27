import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

part 'search_page_event.dart';
part 'search_page_state.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  SearchPageBloc() : super(const SearchPageLoadInProgress());

  final transactionRepository = TransactionRepository();

  @override
  Stream<SearchPageState> mapEventToState(
    SearchPageEvent event,
  ) async* {
    if (event is UpdateSearch) {
      final List<UserTransaction> results =
          await transactionRepository.getTransactionByTitle(event.query);
      yield SearchPageLoadSuccess(
        results: results,
        suggestions: results.take(5).toList(),
      );
    }
  }
}
