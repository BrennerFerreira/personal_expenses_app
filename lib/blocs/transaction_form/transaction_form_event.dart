part of 'transaction_form_bloc.dart';

abstract class TransactionFormEvent extends Equatable {
  const TransactionFormEvent();

  @override
  List<Object?> get props => [];
}

class TitleChanged extends TransactionFormEvent {
  final String newTitle;

  const TitleChanged({required this.newTitle});

  @override
  List<Object?> get props => [newTitle];

  @override
  String toString() => 'TitleChanged(newTitle: $newTitle)';
}

class FormSubmitted extends TransactionFormEvent {
  const FormSubmitted();

  @override
  List<Object?> get props => [];
}
