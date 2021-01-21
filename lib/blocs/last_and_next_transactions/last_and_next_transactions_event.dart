part of 'last_and_next_transactions_bloc.dart';

abstract class LastAndNextTransactionsEvent extends Equatable {
  const LastAndNextTransactionsEvent();

  @override
  List<Object> get props => [];
}

class LastAndNextTransactionLoad extends LastAndNextTransactionsEvent {}
