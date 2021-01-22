part of 'transaction_form_bloc.dart';

class TransactionFormState extends Equatable {
  final String title;
  const TransactionFormState({this.title = ""});

  TransactionFormState copyWith({
    String? title,
  }) {
    return TransactionFormState(
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [title];
}

class TransactionFormInitial extends TransactionFormState {
  final UserTransaction? transaction;
  const TransactionFormInitial({
    this.transaction,
  });

  @override
  List<Object?> get props => [transaction];

  @override
  String toString() => 'TransactionFormInitial(transaction: $transaction)';
}

class TransactionFormError extends TransactionFormState {
  final String? titleError;

  const TransactionFormError({
    this.titleError,
  });

  @override
  List<Object?> get props => [titleError];

  @override
  String toString() => 'TransactionFormError(titleError: $titleError)';
}
