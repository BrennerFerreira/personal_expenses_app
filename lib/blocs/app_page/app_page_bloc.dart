import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:personal_expenses/models/app_page.dart';

part 'page_event.dart';

class AppPageBloc extends Bloc<AppPageEvent, AppPage> {
  AppPageBloc() : super(AppPage.home);

  @override
  Stream<AppPage> mapEventToState(
    AppPageEvent event,
  ) async* {
    if (event is AppPageUpdated) {
      yield event.page;
    }
  }
}
