part of 'account_bloc.dart';

@immutable
abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountLoadAll extends AccountEvent {}
