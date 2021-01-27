part of 'transaction_details_page_bloc.dart';

abstract class TransactionDetailsEvent extends Equatable {
  const TransactionDetailsEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTransactionDetailsPage extends TransactionDetailsEvent {
  final UserTransaction transaction;
  const UpdateTransactionDetailsPage({
    required this.transaction,
  });

  @override
  List<Object?> get props => [transaction];

  @override
  String toString() =>
      'UpdateTransactionDetailsPage(transaction: $transaction)';
}

class DeleteTransaction extends TransactionDetailsEvent {
  final UserTransaction transaction;

  const DeleteTransaction(this.transaction);

  @override
  List<Object?> get props => [transaction];
}

class DeleteAllInstallmentsChanged extends TransactionDetailsEvent {
  final bool newDeleteAllTransactions;

  const DeleteAllInstallmentsChanged({required this.newDeleteAllTransactions});

  @override
  List<Object?> get props => [newDeleteAllTransactions];

  @override
  String toString() =>
      'DeleteAllInstallmentsChanged(newDeleteAllTransactions: $newDeleteAllTransactions)';
}
