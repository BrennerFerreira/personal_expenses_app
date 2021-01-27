part of 'page_view_bloc.dart';

abstract class PageViewEvent extends Equatable {
  const PageViewEvent();

  @override
  List<Object?> get props => [];
}

class ChangePageEvent extends PageViewEvent {
  final int newPage;

  const ChangePageEvent(this.newPage);

  @override
  List<Object?> get props => [newPage];

  @override
  String toString() => 'ChangePage(newPage: $newPage)';
}
