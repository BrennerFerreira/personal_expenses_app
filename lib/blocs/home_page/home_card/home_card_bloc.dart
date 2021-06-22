import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/transaction.dart';
import '../../../repositories/transactions/global_stats_repository.dart';
import '../../../repositories/transactions/transactions_repository.dart';

part 'home_card_event.dart';
part 'home_card_state.dart';

class HomeCardBloc extends Bloc<HomeCardEvent, HomeCardState> {
  HomeCardBloc() : super(HomeCardLoadInProgress());

  final globalStatsRepository = GlobalStatsRepository();
  final transactionRepository = TransactionRepository();

  @override
  Stream<HomeCardState> mapEventToState(
    HomeCardEvent event,
  ) async* {
    if (event is UpdateHomeCard) {
      final Map<String, double> totalBalanceMap =
          await globalStatsRepository.totalBalance();
      final double totalBalance = totalBalanceMap["totalBalance"]!;

      final Map<String, double> pastBalanceMap =
          await globalStatsRepository.pastBalance();
      final double pastBalance = pastBalanceMap["totalBalance"]!;

      final UserTransaction? lastTransaction =
          await transactionRepository.getLastTransaction();

      yield HomeCardLoadSuccess(
        totalBalance: totalBalance,
        pastBalance: pastBalance,
        lastTransaction: lastTransaction,
      );
    }
  }
}
