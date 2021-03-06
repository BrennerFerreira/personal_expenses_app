part of 'transaction_form_bloc.dart';

abstract class TransactionFormEvent extends Equatable {
  const TransactionFormEvent();

  @override
  List<Object?> get props => [];
}

class AddTransaction extends TransactionFormEvent {}

class EditTransaction extends TransactionFormEvent {
  final UserTransaction transaction;

  const EditTransaction({
    required this.transaction,
  });

  @override
  List<Object?> get props => [
        transaction,
      ];

  @override
  String toString() => 'EditTransaction(transaction: $transaction)';
}

class FormCanceled extends TransactionFormEvent {
  const FormCanceled() : super();

  @override
  List<Object?> get props => [];
}

class EditAllInstallmentsChanged extends TransactionFormEvent {
  final bool newEditAllInstallments;
  const EditAllInstallmentsChanged({required this.newEditAllInstallments});

  @override
  List<Object?> get props => [newEditAllInstallments];

  @override
  String toString() =>
      'EditAllInstallmentsChanged(newEditAllInstallments: $newEditAllInstallments)';
}

class IsBetweenAccountsChanged extends TransactionFormEvent {
  final bool newOption;
  const IsBetweenAccountsChanged({required this.newOption});

  @override
  List<Object?> get props => [newOption];

  @override
  String toString() => 'IsBetweenAccountsChanged(newOption: $newOption)';
}

class TitleChanged extends TransactionFormEvent {
  final String newTitle;

  const TitleChanged({required this.newTitle});

  @override
  List<Object?> get props => [newTitle];

  @override
  String toString() => 'TitleChanged(newTitle: $newTitle)';
}

class NewAccountChanged extends TransactionFormEvent {
  final bool newOption;
  const NewAccountChanged({required this.newOption});

  @override
  List<Object?> get props => [newOption];

  @override
  String toString() => 'NewAccountChanged(newOption: $newOption)';
}

class AccountChanged extends TransactionFormEvent {
  final String newAccount;

  const AccountChanged({required this.newAccount});

  @override
  List<Object?> get props => [newAccount];

  @override
  String toString() => 'AccountChanged(newAccount: $newAccount)';
}

class DestinationNewAccountChanged extends TransactionFormEvent {
  final bool newOption;
  const DestinationNewAccountChanged({required this.newOption});

  @override
  List<Object?> get props => [newOption];

  @override
  String toString() => 'DestinationNewAccountChanged(newOption: $newOption)';
}

class DestinationAccountChanged extends TransactionFormEvent {
  final String newDestinationAccount;

  const DestinationAccountChanged({required this.newDestinationAccount});

  @override
  List<Object?> get props => [newDestinationAccount];

  @override
  String toString() =>
      'DestinationAccountChanged(newDestinationAccount: $newDestinationAccount)';
}

class PriceChanged extends TransactionFormEvent {
  final String newPrice;

  const PriceChanged({required this.newPrice});

  @override
  List<Object?> get props => [newPrice];

  @override
  String toString() => 'PriceChanged(newPrice: $newPrice)';
}

class IsIncomeChanged extends TransactionFormEvent {
  final bool newIsIncome;

  const IsIncomeChanged({required this.newIsIncome});

  @override
  List<Object?> get props => [newIsIncome];

  @override
  String toString() => 'IsIncomeChanged(newIsIncome: $newIsIncome)';
}

class DateChanged extends TransactionFormEvent {
  final DateTime newDate;

  const DateChanged({required this.newDate});

  @override
  List<Object?> get props => [newDate];

  @override
  String toString() => 'DateChanged(newDate: $newDate)';
}

class IsInstallmentsChanged extends TransactionFormEvent {
  final bool newIsInstallments;

  const IsInstallmentsChanged({required this.newIsInstallments});

  @override
  List<Object?> get props => [newIsInstallments];

  @override
  String toString() =>
      'IsInstallmentsChanged(newIsInstallments: $newIsInstallments)';
}

class NumberOfInstallmentsChanged extends TransactionFormEvent {
  final String newNumberOfInstallments;

  const NumberOfInstallmentsChanged({required this.newNumberOfInstallments});

  @override
  List<Object?> get props => [newNumberOfInstallments];

  @override
  String toString() =>
      'NumberOfInstallmentsChanged(newNumberOfInstallments: $newNumberOfInstallments)';
}

class FormSubmitted extends TransactionFormEvent {
  const FormSubmitted();

  @override
  List<Object?> get props => [];
}
