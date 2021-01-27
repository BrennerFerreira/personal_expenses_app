part of 'search_page_bloc.dart';

abstract class SearchPageState extends Equatable {
  const SearchPageState();

  @override
  List<Object?> get props => [];
}

class SearchPageLoadInProgress extends SearchPageState {
  const SearchPageLoadInProgress();

  @override
  List<Object?> get props => [];
}

class SearchPageLoadSuccess extends SearchPageState {
  final List<UserTransaction> results;
  final List<UserTransaction> suggestions;
  const SearchPageLoadSuccess({
    this.results = const [],
    this.suggestions = const [],
  });

  @override
  List<Object> get props => [results, suggestions];

  @override
  String toString() =>
      'SearchPageLoadSuccess(results: $results, suggestions: $suggestions)';
}
