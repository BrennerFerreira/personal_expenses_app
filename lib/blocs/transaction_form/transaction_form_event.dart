part of 'transaction_form_bloc.dart';

abstract class TransactionFormEvent extends Equatable {
  const TransactionFormEvent();

  @override
  List<Object?> get props => [];
}

class AddTransaction extends TransactionFormEvent {}

class EditTransaction extends TransactionFormEvent {
  final UserTransaction transaction;

  const EditTransaction({required this.transaction});

  @override
  List<Object?> get props => [transaction];

  @override
  String toString() => 'EditTransaction(transaction: $transaction)';
}

class TitleChanged extends TransactionFormEvent {
  final String newTitle;

  const TitleChanged({required this.newTitle});

  @override
  List<Object?> get props => [newTitle];

  @override
  String toString() => 'TitleChanged(newTitle: $newTitle)';
}

class InvertNewAccountValue extends TransactionFormEvent {
  final bool newOption;
  const InvertNewAccountValue({required this.newOption});

  @override
  List<Object?> get props => [newOption];

  @override
  String toString() => 'InvertNewAccountValue(newOption: $newOption)';
}

class AccountChanged extends TransactionFormEvent {
  final String newAccount;

  const AccountChanged({required this.newAccount});

  @override
  List<Object?> get props => [newAccount];

  @override
  String toString() => 'AccountChanged(newAccount: $newAccount)';
}

class PriceChanged extends TransactionFormEvent {
  final String newPrice;

  const PriceChanged({required this.newPrice});

  @override
  List<Object?> get props => [newPrice];

  @override
  String toString() => 'PriceChanged(newPrice: $newPrice)';
}

class FormSubmitted extends TransactionFormEvent {
  const FormSubmitted();

  @override
  List<Object?> get props => [];
}
