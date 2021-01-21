part of 'account_stats_bloc.dart';

abstract class AccountStatsEvent extends Equatable {
  const AccountStatsEvent();

  @override
  List<Object> get props => [];
}

class AccountStatsUpdated extends AccountStatsEvent {
  final String account;

  const AccountStatsUpdated(this.account);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AccountStatsUpdated(account: $account)';
}

class AccountStatsLoadAll extends AccountStatsEvent {}
