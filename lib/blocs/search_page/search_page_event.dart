part of 'search_page_bloc.dart';

abstract class SearchPageEvent extends Equatable {
  const SearchPageEvent();

  @override
  List<Object> get props => [];
}

class UpdateSearch extends SearchPageEvent {
  final String query;

  const UpdateSearch(this.query);

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'UpdateSearch(query: $query)';
}
