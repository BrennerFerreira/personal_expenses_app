import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expenses/blocs/search_page/search_page_bloc.dart';
import 'package:personal_expenses/pages/common/blurred_card.dart';
import 'package:personal_expenses/pages/common/common_circular_indicator.dart';
import 'package:personal_expenses/pages/common/common_error_text.dart';
import 'package:personal_expenses/pages/common/common_scaffold.dart';
import 'package:personal_expenses/pages/common/user_transaction_tile.dart';
import 'package:personal_expenses/pages/home_page/home_page.dart';
import 'package:personal_expenses/pages/transaction_details_page/transaction_detail_page.dart';

class SearchResults extends StatelessWidget {
  final String query;

  const SearchResults({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchPageBloc = SearchPageBloc()..add(UpdateSearch(query));
    return BlocProvider<SearchPageBloc>(
      create: (context) => searchPageBloc,
      child: CommonScaffold(
        isSearch: true,
        title: '"$query"',
        children: [
          BlocBuilder<SearchPageBloc, SearchPageState>(
            value: searchPageBloc,
            builder: (context, state) {
              if (state is SearchPageLoadInProgress) {
                return CommonCircularIndicator();
              } else if (state is SearchPageLoadSuccess) {
                return Flexible(
                  child: BlurredCard(
                    child: state.results.isEmpty
                        ? Center(
                            child: query.length < 3
                                ? const Text("O termo procurado é muito curto.")
                                : const Text("Nenhuma transação encontrada."),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => TransactionDetailsPage(
                                        transaction: state.results[index],
                                        fromSearch: true,
                                        lastPage: MaterialPageRoute(
                                          builder: (_) => HomePage(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: UserTransactionTile(
                                  transaction: state.results[index],
                                ),
                              );
                            },
                          ),
                  ),
                );
              } else {
                return CommonErrorText();
              }
            },
          ),
        ],
      ),
    );
  }
}
