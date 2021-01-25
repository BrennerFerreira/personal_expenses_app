import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/home_page/home_page_blocs.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/home_page/widgets/custom_dropdown_menu.dart';

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
                              return UserTransactionTile(
                                  transaction:
                                      state.filteredTransactions[index]);
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
