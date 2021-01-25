part of 'transaction_details_bloc.dart';

abstract class TransactionDetailsEvent extends Equatable {
  const TransactionDetailsEvent();

  @override
  List<Object?> get props => [];
}

class DeleteTransaction extends TransactionDetailsEvent {
  final UserTransaction transaction;

  const DeleteTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}
