import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeping_time_mobile/data/provider/campain_provider/campain_provider.dart';

import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';

part 'timekeeping_process_event.dart';

part 'timekeeping_process_state.dart';

class TimeKeepingProcessBloc
    extends Bloc<TimeKeepingProcessEvent, TimeKeepingProcessState> {
  TimeKeepingProcessBloc({
    // required LocalStore localStore,
    required CampaignProvider campaignProvider,
  })  : _campaignProvider = campaignProvider,
        // _localStore = localStore,
        super(TimeKeepingProcessState());

  final CampaignProvider _campaignProvider;

  @override
  Stream<TimeKeepingProcessState> mapEventToState(
      TimeKeepingProcessEvent event) async* {
    if (event is TimeKeepingProcess) {
      yield* _mapTimeKeepingProcessState(event);
    }
  }

  Stream<TimeKeepingProcessState> _mapTimeKeepingProcessState(
      TimeKeepingProcess event) async* {
    yield state.copyWith(processStatus: ProcessStatus.loading);

    try {
      await _campaignProvider.report();
      yield state.copyWith(processStatus: ProcessStatus.success);
    } catch (e) {
      yield state.copyWith(
          processStatus: ProcessStatus.failure,
          error: ResponseError.bindResponseError(e));
    }
  }
}
