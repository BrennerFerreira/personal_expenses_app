import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/search_page/search_page.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';
import 'package:personal_expenses/pages/home_page/widgets/date_range_card.dart';
import 'package:personal_expenses/pages/home_page/widgets/future_transactions_card.dart';
import 'package:personal_expenses/pages/home_page/widgets/home_card.dart';
import 'package:personal_expenses/pages/home_page/widgets/page_dots.dart';
import 'package:personal_expenses/pages/home_page/widgets/transaction_list.dart';
import 'package:personal_expenses/pages/home_page/widgets/accounts_card.dart';
import 'package:personal_expenses/pages/user_transaction_form_page/user_transaction_form_page.dart';

class HomePage extends StatelessWidget {
  final pageViewBloc = PageViewBloc();
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isHomePage: true,
      title: "Início",
      leadingButton: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.025,
        ),
        child: IconButton(
          icon: const Icon(Icons.search, size: 35),
          onPressed: () {
            showSearch(
              context: context,
              delegate: Search(),
            );
          },
        ),
      ),
      actionButtons: [
        IconButton(
          icon: const Icon(Icons.add, size: 35),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              builder: (context) => const UserTransactionFormPage(),
            );
          },
        ),
      ],
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: BlocProvider<PageViewBloc>(
              create: (context) => pageViewBloc,
              child: PageView(
                controller: PageController(viewportFraction: 0.925),
                onPageChanged: (newPage) {
                  pageViewBloc.add(ChangePageEvent(newPage));
                },
                children: [
                  HomeCard(),
                  AccountsCard(),
                  DateRangeTransactionsCard(),
                  FutureTransactionsCard(),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: PageDots(
            bloc: pageViewBloc,
          ),
        ),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.905,
            child: TransactionList(),
          ),
        ),
      ],
    );
  }
}
