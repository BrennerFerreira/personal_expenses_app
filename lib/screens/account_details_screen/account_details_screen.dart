import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/blocs.dart';
import 'package:personal_expenses/screens/account_details_screen/widgets/account_transaction_list.dart';
import 'package:personal_expenses/screens/common/balance_card.dart';

class AccountDetailsScreen extends StatelessWidget {
  final String account;

  const AccountDetailsScreen({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountFilteredTransactionsBloc>(
          create: (_) => AccountFilteredTransactionsBloc()
            ..add(
              AccountFilterUpdated(account),
            ),
        ),
        BlocProvider<AccountStatsBloc>(
          create: (_) => AccountStatsBloc()
            ..add(
              AccountStatsUpdated(account),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.025,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        BlocBuilder<AccountStatsBloc, AccountStatsState>(
                          builder: (context, state) {
                            if (state is AccountStatsLoadInProgress) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            } else if (state is AccountStatsLoadSuccess) {
                              return Hero(
                                tag: account,
                                child: BalanceCard(
                                  isHomePage: false,
                                  totalBalance: state.totalBalance,
                                  totalIncome: state.lastThirtyDaysIncome,
                                  totalOutcome: state.lastThirtyDaysOutcome,
                                ),
                              );
                            } else {
                              return const Text(
                                "Erro aos calcular os dados. Por favor, reinicie o aplicativo",
                                textAlign: TextAlign.center,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<AccountFilteredTransactionsBloc,
                            AccountFilteredTransactionsState>(
                          builder: (context, state) {
                            if (state
                                is AccountFilteredTransactionsLoadInProgress) {
                              return Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            } else if (state
                                is AccountFilteredTransactionsLoadSuccess) {
                              return AccountTransactionList(
                                transactionList:
                                    state.accountFilteredTransactions,
                                onWillPop: () async {
                                  BlocProvider.of<
                                      AccountFilteredTransactionsBloc>(
                                    context,
                                  ).add(
                                    AccountFilterUpdated(account),
                                  );
                                  BlocProvider.of<AccountStatsBloc>(context)
                                      .add(
                                    AccountStatsUpdated(
                                      account,
                                    ),
                                  );
                                  return true;
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
