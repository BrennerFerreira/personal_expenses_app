part of 'home_card_bloc.dart';

abstract class HomeCardState extends Equatable {
  const HomeCardState();

  @override
  List<Object?> get props => [];
}

class HomeCardLoadInProgress extends HomeCardState {}

class HomeCardLoadSuccess extends HomeCardState {
  final double balance;
  final UserTransaction? lastTransaction;

  const HomeCardLoadSuccess({
    required this.balance,
    required this.lastTransaction,
  });

  @override
  List<Object?> get props => [
        balance,
        lastTransaction,
      ];

  @override
  String toString() =>
      'HomeCardLoadSuccess(balance: $balance, lastTransaction: $lastTransaction)';
}
