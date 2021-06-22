import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/search_page/search_page_bloc.dart';
import '../../common/blurred_card.dart';
import '../../common/common_circular_indicator.dart';
import '../../common/common_error_text.dart';
import '../../common/user_transaction_tile.dart';
import '../../home_page/home_page.dart';
import '../../transaction_details_page/transaction_detail_page.dart';

class SearchSuggestions extends StatelessWidget {
  final String query;

  const SearchSuggestions({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchPageBloc = SearchPageBloc()..add(UpdateSearch(query));
    return BlocProvider<SearchPageBloc>(
      create: (_) => searchPageBloc,
      child: BlocBuilder<SearchPageBloc, SearchPageState>(
        bloc: searchPageBloc,
        builder: (context, state) {
          if (state is SearchPageLoadInProgress) {
            return CommonCircularIndicator();
          } else if (state is SearchPageLoadSuccess) {
            return state.suggestions.isEmpty
                ? query.isEmpty
                    ? const Center(
                        child: Text("Digite um termo de busca."),
                      )
                    : query.length < 3
                        ? const Center(
                            child: Text("Digite um termo de busca maior."),
                          )
                        : const Center(
                            child: Text("Nenhuma transação encontrada."),
                          )
                : Container(
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02,
                      horizontal: MediaQuery.of(context).size.width * 0.025,
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: state.suggestions.length,
                      itemBuilder: (context, index) {
                        return BlurredCard(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => TransactionDetailsPage(
                                    transaction: state.suggestions[index],
                                    fromSearch: true,
                                    lastPage: MaterialPageRoute(
                                      builder: (_) => HomePage(),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: UserTransactionTile(
                              transaction: state.suggestions[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          } else {
            return CommonErrorText();
          }
        },
      ),
    );
  }
}
