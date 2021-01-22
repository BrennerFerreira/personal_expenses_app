import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_view_event.dart';

class PageViewBloc extends Bloc<PageViewEvent, int> {
  PageViewBloc() : super(0);

  @override
  Stream<int> mapEventToState(
    PageViewEvent event,
  ) async* {
    if (event is ChangePageEvent) {
      yield event.newPage;
    }
  }
}
