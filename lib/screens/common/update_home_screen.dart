import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/old_blocs/blocs.dart';
import 'package:personal_expenses/models/visibility_filter.dart';

class UpdateHomeScreen {
  void updateHome(BuildContext context) {
    BlocProvider.of<GlobalStatsBloc>(context).add(
      const GlobalStatsUpdated(),
    );

    BlocProvider.of<FilteredTransactionsBloc>(
      context,
      listen: false,
    ).add(
      const FilterUpdated(
        VisibilityFilter.lastSevenDays,
      ),
    );

    BlocProvider.of<AccountStatsBloc>(context).add(
      AccountStatsLoadAll(),
    );

    BlocProvider.of<DateRangeStatsBloc>(context).add(
      DateRangeStatsUpdated(
        DateTimeRange(
          start: DateTime(DateTime.now().year, DateTime.now().month),
          end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
        ),
      ),
    );

    BlocProvider.of<FutureTransactionsStatsBloc>(context).add(
      const FutureTransactionsStatsUpdated(),
    );

    BlocProvider.of<LastAndNextTransactionsBloc>(context).add(
      LastAndNextTransactionLoad(),
    );
  }
}
