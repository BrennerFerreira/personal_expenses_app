part of 'home_card_bloc.dart';

abstract class HomeCardState extends Equatable {
  const HomeCardState();

  @override
  List<Object?> get props => [];
}

class HomeCardLoadInProgress extends HomeCardState {}

class HomeCardLoadSuccess extends HomeCardState {
  final double totalBalance;
  final double pastBalance;
  final UserTransaction? lastTransaction;

  const HomeCardLoadSuccess({
    required this.totalBalance,
    required this.pastBalance,
    required this.lastTransaction,
  });

  @override
  List<Object?> get props => [
        totalBalance,
        pastBalance,
        lastTransaction,
      ];

  @override
  String toString() =>
      'HomeCardLoadSuccess(totalBalance: $totalBalance, pastBalance: $pastBalance, lastTransaction: $lastTransaction)';
}
