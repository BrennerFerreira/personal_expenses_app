part of 'global_stats_bloc.dart';

abstract class GlobalStatsEvent extends Equatable {
  const GlobalStatsEvent();

  @override
  List<Object> get props => [];
}

class GlobalStatsUpdated extends GlobalStatsEvent {
  const GlobalStatsUpdated();

  @override
  List<Object> get props => [];
}
