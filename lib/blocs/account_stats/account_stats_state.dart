part of 'account_stats_bloc.dart';

abstract class AccountStatsState extends Equatable {
  const AccountStatsState();

  @override
  List<Object> get props => [];
}

class AccountStatsLoadInProgress extends AccountStatsState {}

class AccountStatsLoadSuccess extends AccountStatsState {
  final double totalBalance;
  final double lastThirtyDaysIncome;
  final double lastThirtyDaysOutcome;
  final String account;

  const AccountStatsLoadSuccess(
      {required this.totalBalance,
      required this.lastThirtyDaysIncome,
      required this.lastThirtyDaysOutcome,
      required this.account});

  @override
  List<Object> get props => [
        totalBalance,
        lastThirtyDaysIncome,
        lastThirtyDaysOutcome,
        account,
      ];

  @override
  String toString() =>
      'AccountStatsLoadSuccess(totalBalance: $totalBalance, lastThirtyDaysIncome: $lastThirtyDaysIncome, lastThirtyDaysOutcome: $lastThirtyDaysOutcome, account: $account)';
}

class AccountStatsLoadAllSuccess extends AccountStatsState {
  final List<Map<String, double>> accountsBalanceMap;

  const AccountStatsLoadAllSuccess({
    required this.accountsBalanceMap,
  });

  @override
  List<Object> get props => [accountsBalanceMap];

  @override
  String toString() =>
      'AccountStatsLoadSuccess(accountsBalanceMap: $accountsBalanceMap)';
}
