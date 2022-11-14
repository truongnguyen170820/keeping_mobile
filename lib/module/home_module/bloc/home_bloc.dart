import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is NextPage) {
      yield* _mapNextPageToState(event);
    }
  }

  Stream<HomeState> _mapNextPageToState(NextPage event) async* {
    yield state.copyWith();
    try {
      switch (event.homeStatus) {
        case HomeStatus.home:
          yield state.copyWith(homeStatus: HomeStatus.home);
          return;
        case HomeStatus.schedule:
          yield state.copyWith(homeStatus: HomeStatus.schedule);
          return;
        case HomeStatus.profile:
          yield state.copyWith(homeStatus: HomeStatus.profile);
          return;
      }
    } catch (ex) {
      yield state.copyWith();
    }
  }
}
