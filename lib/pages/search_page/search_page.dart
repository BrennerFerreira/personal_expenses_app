import 'package:flutter/material.dart';

import 'widgets/search_results.dart';
import 'widgets/search_suggestions.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.015,
        ),
        child: IconButton(
          icon: const Icon(
            Icons.close,
            size: 35,
            semanticLabel: "Limpar pesquisa.",
          ),
          onPressed: query.isEmpty
              ? null
              : () {
                  query = "";
                },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        size: 35,
        semanticLabel: "Retornar para a tela anterior.",
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestions(query: query);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }
}
