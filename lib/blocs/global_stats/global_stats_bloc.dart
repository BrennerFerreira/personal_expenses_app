import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/repositories/transactions/global_stats_repository.dart';

part 'global_stats_event.dart';
part 'global_stats_state.dart';

class GlobalStatsBloc extends Bloc<GlobalStatsEvent, GlobalStatsState> {
  GlobalStatsBloc() : super(GlobalStatsLoadInProgress());

  final globalStatsRepository = GlobalStatsRepository();

  @override
  Stream<GlobalStatsState> mapEventToState(
    GlobalStatsEvent event,
  ) async* {
    if (event is GlobalStatsUpdated) {
      final balanceMap = await globalStatsRepository.lastThirtyDaysBalance();
      yield GlobalStatsLoadSuccess(
        totalBalance: balanceMap['totalBalance'] as double,
        lastThirtyDaysIncome: balanceMap['totalIncome'] as double,
        lastThirtyDaysOutcome: balanceMap['totalOutcome'] as double,
      );
    }
  }
}
