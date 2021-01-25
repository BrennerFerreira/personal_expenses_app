import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_expenses/blocs/custom_bloc_observer.dart';
import 'package:personal_expenses/blocs/transaction_form/transaction_form_bloc.dart';
import 'package:personal_expenses/theme/calendar_primary_pallete.dart';

import 'pages/home_page/home_page.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormBloc>(
      create: (_) => TransactionFormBloc(),
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
          canvasColor: Colors.transparent,
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
        home: HomePage(),
        // ),
      ),
    );
  }
}
