part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionLoadInProgress extends TransactionState {}

class TransactionLoadSuccess extends TransactionState {}

class TransactionLoadFailure extends TransactionState {}
