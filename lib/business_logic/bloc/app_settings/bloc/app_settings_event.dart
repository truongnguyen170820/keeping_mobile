part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {}

class AppInitial extends AppSettingsEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUser extends AppSettingsEvent {
  UpdateUser();

  // final UserModel user;

  @override
  List<Object?> get props => [
        // user,
      ];
}

class RefreshAccountProfile extends AppSettingsEvent {
  RefreshAccountProfile();

  @override
  List<Object?> get props => [];
}

class LikeCampaign extends AppSettingsEvent {
  LikeCampaign({this.campaignId});

  final int? campaignId;

  @override
  List<Object?> get props => [campaignId];
}

class UnLikeCampaign extends AppSettingsEvent {
  UnLikeCampaign({this.campaignId});

  final int? campaignId;

  @override
  List<Object?> get props => [campaignId];
}

class FetchDataNotifi extends AppSettingsEvent{
  FetchDataNotifi({this.limit, this.offset});
  final int? limit;
  final int? offset;

  @override
  // TODO: implement props
  List<Object?> get props => [limit, offset ];
}

