import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/account_details_page/account_details_page_bloc.dart';
import 'package:personal_expenses/pages/account_details_page/widgets/account_transaction_list.dart';
import 'package:personal_expenses/pages/account_list_page/accounts_list_page.dart';
import 'package:personal_expenses/pages/common/balance_card.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';

class AccountDetailsPage extends StatefulWidget {
  final String account;

  const AccountDetailsPage({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  late AccountDetailsPageBloc accountDetailsPageBloc;

  @override
  void initState() {
    super.initState();
    accountDetailsPageBloc = AccountDetailsPageBloc()
      ..add(
        UpdateAccountDetailsPage(widget.account),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountDetailsPageBloc>(
      create: (_) => accountDetailsPageBloc,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => AccountListPage(),
            ),
            (route) => false,
          );
          return true;
        },
        child: CommonScaffold(
          leadingButton: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => AccountListPage(),
                  ),
                  (route) => false,
                );
              }),
          title: widget.account,
          children: [
            Expanded(
              child: BlurredCard(
                child: BlocBuilder<AccountDetailsPageBloc,
                    AccountDetailsPageState>(
                  value: accountDetailsPageBloc,
                  builder: (context, state) {
                    if (state is AccountDetailsPageLoadInProgress) {
                      return CommonCircularIndicator();
                    } else if (state is AccountDetailsPageLoadSuccess) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: widget.account,
                            child: BalanceCard(
                              totalBalance: state.balance,
                              totalIncome: state.income,
                              totalOutcome: state.outcome,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text("Transações cadastradas:"),
                          const SizedBox(height: 10),
                          AccountTransactionList(
                            transactionList: state.transactionList,
                            account: widget.account,
                          ),
                        ],
                      );
                    } else {
                      return CommonErrorText();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
