import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/future_transactions_page/future_transactions_page_bloc.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/future_transactions_page/widgets/future_transactions_balance_card.dart';
import 'package:personal_expenses/pages/home_page/home_page.dart';
import 'package:personal_expenses/pages/transaction_details_page/transaction_detail_page.dart';

class FutureTransactionsPage extends StatefulWidget {
  @override
  _FutureTransactionsPageState createState() => _FutureTransactionsPageState();
}

class _FutureTransactionsPageState extends State<FutureTransactionsPage> {
  late FutureTransactionsPageBloc futureTransactionsPageBloc;

  @override
  void initState() {
    super.initState();
    futureTransactionsPageBloc = FutureTransactionsPageBloc()
      ..add(
        const UpdateFutureTransactionsPage(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FutureTransactionsPageBloc>(
      create: (_) => futureTransactionsPageBloc,
      child:
          BlocBuilder<FutureTransactionsPageBloc, FutureTransactionsPageState>(
        value: futureTransactionsPageBloc,
        builder: (context, state) {
          if (state is FutureTransactionsPageLoadInProgress) {
            return CommonCircularIndicator();
          } else if (state is FutureTransactionsPageLoadSuccess) {
            return CommonScaffold(
              leadingButton: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                      (route) => false,
                    );
                  }),
              title: "Transações agendadas",
              children: [
                Expanded(
                  child: BlurredCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        FutureTransactionsBalanceCard(
                          totalIncome: state.income,
                          totalOutcome: state.outcome,
                          highestIncome: state.highestIncome,
                          highestOutcome: state.highestOutcome,
                        ),
                        const SizedBox(height: 10),
                        if (state.transactionList.isNotEmpty)
                          const Text("Transações agendadas:"),
                        const SizedBox(height: 10),
                        Expanded(
                          child: state.transactionList.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Não há transações agendadas.",
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: state.transactionList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                TransactionDetailsPage(
                                              transaction:
                                                  state.transactionList[index],
                                              lastPage: MaterialPageRoute(
                                                builder: (_) =>
                                                    FutureTransactionsPage(),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: UserTransactionTile(
                                        transaction:
                                            state.transactionList[index],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return CommonErrorText();
          }
        },
      ),
    );
  }
}
