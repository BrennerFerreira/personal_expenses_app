part of 'last_and_next_transactions_bloc.dart';

abstract class LastAndNextTransactionsState extends Equatable {
  const LastAndNextTransactionsState();

  @override
  List<Object> get props => [];
}

class LastAndNextTransactionsLoadInProgress
    extends LastAndNextTransactionsState {}

class LastAndNextTransactionsLoadSuccess extends LastAndNextTransactionsState {
  final UserTransaction? lastTransaction;
  final UserTransaction? nextTransaction;

  const LastAndNextTransactionsLoadSuccess({
    required this.lastTransaction,
    required this.nextTransaction,
  });

  @override
  String toString() =>
      'LastAndNextTransactionsLoadSuccess(lastTransaction: $lastTransaction, nextTransaction: $nextTransaction)';
}
