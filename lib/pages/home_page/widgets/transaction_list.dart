import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home_page/home_page_blocs.dart';
import '../../common/blurred_card.dart';
import '../../common/common_circular_indicator.dart';
import '../../common/common_error_text.dart';
import '../../common/user_transaction_tile.dart';
import '../../transaction_details_page/transaction_detail_page.dart';
import '../home_page.dart';
import 'custom_dropdown_menu.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late FilteredTransactionsListBloc filteredTransactionListBloc;

  @override
  void initState() {
    super.initState();
    filteredTransactionListBloc = FilteredTransactionsListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlurredCard(
      isHomePage: true,
      child: BlocProvider<FilteredTransactionsListBloc>(
        create: (context) => filteredTransactionListBloc,
        child: BlocBuilder<FilteredTransactionsListBloc,
            FilteredTransactionsListState>(
          builder: (context, state) {
            if (state is FilteredTransactionsListLoadInProgress) {
              return CommonCircularIndicator();
            } else if (state is FilteredTransactionsListLoadSuccess) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is FilteredTransactionsListLoadSuccess)
                    CustomDropDownMenu(bloc: filteredTransactionListBloc),
                  Expanded(
                    child: state.filteredTransactions.isEmpty
                        ? const Center(
                            child: Text(
                              "Não há transações cadastradas no período selecionado",
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.filteredTransactions.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => TransactionDetailsPage(
                                        transaction:
                                            state.filteredTransactions[index],
                                        lastPage: MaterialPageRoute(
                                          builder: (_) => HomePage(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: UserTransactionTile(
                                    transaction:
                                        state.filteredTransactions[index]),
                              );
                            },
                          ),
                  ),
                ],
              );
            } else {
              return CommonErrorText();
            }
          },
        ),
      ),
    );
  }
}
