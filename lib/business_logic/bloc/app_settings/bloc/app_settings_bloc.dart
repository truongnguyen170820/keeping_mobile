import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeping_time_mobile/common/base_bloc_state.dart';
import 'package:keeping_time_mobile/common/response_error.dart';
import '../../../../data/provider/account_provider/account_provider.dart';
import '../../../../data/provider/campain_provider/campain_provider.dart';
part 'app_settings_event.dart';

part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc({
    required AccountProvider accountProvider,
    required CampaignProvider campaignProvider,
  })  : _accountProvider = accountProvider,
        _campaignProvider = campaignProvider,
        super(AppSettingsState());

  final CampaignProvider _campaignProvider;
  final AccountProvider _accountProvider;

  @override
  Stream<AppSettingsState> mapEventToState(
    AppSettingsEvent event,
  ) async* {
    if (event is AppInitial) {
      yield* _mapAccountInitialToState();
    } else if (event is LikeCampaign) {
      yield* _mapLikeCampaignToState(event);
    } else if (event is UnLikeCampaign) {
      yield* _mapUnLikeCampaignToState(event);
    }
  }

  Stream<AppSettingsState> _mapAccountInitialToState() async* {
    try {
      // dynamic response = await _campaignProvider.fetchCategory();
      // dynamic responseLocation = await _campaignProvider.fetchLocation();
      yield state.copyWith(
          // hashtags: response,
          // location: responseLocation,
          // dataUser: responseDataUser
      );
    } catch (e) {}
  }

  Stream<AppSettingsState> _mapLikeCampaignToState(LikeCampaign event) async* {
    try {
      // await _campaignProvider.likeCampaign(campaignId: event.campaignId);
    } catch (e) {}
  }

  Stream<AppSettingsState> _mapUnLikeCampaignToState(
      UnLikeCampaign event) async* {
    try {
      // await _campaignProvider.unLikeCampaign(campaignId: event.campaignId);
    } catch (e) {}
  }
}
