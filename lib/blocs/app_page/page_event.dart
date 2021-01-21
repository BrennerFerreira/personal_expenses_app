part of 'app_page_bloc.dart';

abstract class AppPageEvent extends Equatable {
  const AppPageEvent();

  @override
  List<Object> get props => [];
}

class AppPageUpdated extends AppPageEvent {
  final AppPage page;

  const AppPageUpdated(this.page);

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'PageUpdated(page: $page)';
}
