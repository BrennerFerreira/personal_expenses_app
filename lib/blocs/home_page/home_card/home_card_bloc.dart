import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/repositories/transactions/global_stats_repository.dart';
import 'package:personal_expenses/repositories/transactions/transactions_repository.dart';

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
      final Map<String, double> balanceMap =
          await globalStatsRepository.lastThirtyDaysBalance();
      final double balance = balanceMap["totalBalance"] as double;
      final UserTransaction? lastTransaction =
          await transactionRepository.getLastTransaction();
      yield HomeCardLoadSuccess(
        balance: balance,
        lastTransaction: lastTransaction,
      );
    }
  }
}
