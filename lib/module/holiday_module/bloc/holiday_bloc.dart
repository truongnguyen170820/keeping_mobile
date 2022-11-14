import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/api_response_error.dart';
import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';
import '../../../data/provider/campain_provider/campain_provider.dart';

part 'holiday_event.dart';

part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  HolidayBloc({required CampaignProvider campaignProvider})
      : _campaignProvider = campaignProvider,
        super(HolidayState());

  final CampaignProvider _campaignProvider;

  @override
  Stream<HolidayState> mapEventToState(HolidayEvent event) async* {
    if (event is Report) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<HolidayState> _mapLoginToState(Report event) async* {
    yield state.copyWith(
      reportStatus: HolidayStatus.loading,
    );
    if (event.topic != null && event.topic!.isEmpty) {
      yield state.copyWith(
          reportStatus: HolidayStatus.failure,
          error: ResponseError.bindResponseError(
              ApiResponseError(message: 'Missing Topic!')));
    } else if (event.content != null && event.content!.isEmpty) {
      yield state.copyWith(
          reportStatus: HolidayStatus.failure,
          error: ResponseError.bindResponseError(
              ApiResponseError(message: 'Missing Content!')));
    } else {
      try {
        await _campaignProvider.report(
          topic: event.topic,
          content: event.content,
        );
        yield state.copyWith(
          reportStatus: HolidayStatus.success,
        );
      } catch (ex) {
        yield state.copyWith(reportStatus: HolidayStatus.failure);
      }
    }
  }
}
