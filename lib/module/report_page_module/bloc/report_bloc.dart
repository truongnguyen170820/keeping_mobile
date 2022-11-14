import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/api_response_error.dart';
import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';
import '../../../data/provider/campain_provider/campain_provider.dart';

part 'report_state.dart';

part 'report_event.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc({required CampaignProvider campaignProvider})
      : _campaignProvider = campaignProvider,
        super(ReportState());

  final CampaignProvider _campaignProvider;

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is Report) {
      yield* _mapLoginToState(event);
    }
  }

  Stream<ReportState> _mapLoginToState(Report event) async* {
    yield state.copyWith(
      reportStatus: ReportStatus.loading,
    );
    if (event.topic != null && event.topic!.isEmpty) {
      yield state.copyWith(
          reportStatus: ReportStatus.failure,
          error: ResponseError.bindResponseError(
              ApiResponseError(message: 'Missing Topic!')));
    } else if (event.content != null && event.content!.isEmpty) {
      yield state.copyWith(
          reportStatus: ReportStatus.failure,
          error: ResponseError.bindResponseError(
              ApiResponseError(message: 'Missing Content!')));
    } else {
      try {
        await _campaignProvider.report(
          topic: event.topic,
          content: event.content,
        );
        yield state.copyWith(
          reportStatus: ReportStatus.success,
        );
      } catch (ex) {
        yield state.copyWith(reportStatus: ReportStatus.failure);
      }
    }
  }
}