import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/blocs/custom_bloc_observer.dart';
import 'package:personal_expenses/models/visibility_filter.dart';
import 'package:personal_expenses/screens/home_screen/home_screen.dart';
import 'package:personal_expenses/theme/calendar_primary_pallete.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalStatsBloc>(
          create: (_) => GlobalStatsBloc()..add(const GlobalStatsUpdated()),
        ),
        BlocProvider<FilteredTransactionsBloc>(
          create: (_) => FilteredTransactionsBloc()
            ..add(
              const FilterUpdated(
                VisibilityFilter.lastSevenDays,
              ),
            ),
        ),
        BlocProvider<AccountStatsBloc>(
          create: (_) => AccountStatsBloc()..add(AccountStatsLoadAll()),
        ),
        BlocProvider<DateRangeStatsBloc>(
          create: (_) => DateRangeStatsBloc()
            ..add(
              DateRangeStatsUpdated(
                DateTimeRange(
                  start: DateTime(DateTime.now().year, DateTime.now().month),
                  end: DateTime(
                      DateTime.now().year, DateTime.now().month + 1, 0),
                ),
              ),
            ),
        ),
        BlocProvider<FutureTransactionsStatsBloc>(
          create: (_) => FutureTransactionsStatsBloc()
            ..add(
              const FutureTransactionsStatsUpdated(),
            ),
        ),
        BlocProvider<LastAndNextTransactionsBloc>(
          create: (_) => LastAndNextTransactionsBloc()
            ..add(
              LastAndNextTransactionLoad(),
            ),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', "BR"),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Personal Expenses App',
        theme: ThemeData(
          primarySwatch: PrimaryPallete.mainPallete,
          primaryColor: const Color(0xFF4B20C5),
          accentColor: const Color(0xFF6CEDFE),
          backgroundColor: const Color(0xFF4B20C5),
          errorColor: const Color(0xFFFD5200),
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Color(0xFF4B20C5),
          ),
          scaffoldBackgroundColor: const Color(0xFF4B20C5),
          fontFamily: "Fira-Sans",
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.zero,
            color: Colors.transparent,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
