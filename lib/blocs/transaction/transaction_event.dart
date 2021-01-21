part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionLoad extends TransactionEvent {}

class TransactionAdded extends TransactionEvent {
  final UserTransaction transaction;

  const TransactionAdded(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionAdded(transaction: $transaction)';
}

class TransactionUpdated extends TransactionEvent {
  final UserTransaction transaction;

  const TransactionUpdated(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionUpdated(transaction: $transaction)';
}

class TransactionDeleted extends TransactionEvent {
  final UserTransaction transaction;

  const TransactionDeleted(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionDeleted(transaction: $transaction)';
}
