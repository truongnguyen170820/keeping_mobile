part of 'app_settings_bloc.dart';

enum AppSettingStatus { initial, loading, success, failure }

enum AppSettingStatusNotify { initial, loading, success, failure }

class AppSettingsState extends BaseBlocState {
  const AppSettingsState({
    this.appSettingStatus = AppSettingStatus.initial,
    this.appSettingStatusNotify = AppSettingStatusNotify.initial,
    this.hashtags,
    this.location,
    this.dataPoint,
    this.latitude,
    this.dataUser,
    this.longitude,
    this.mineCampaignCount,
    this.countUnreadNotify,

    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final dynamic hashtags;
  final dynamic location;
  final dynamic dataUser;
  final dynamic dataPoint;
  final AppSettingStatus appSettingStatus;
  final AppSettingStatusNotify appSettingStatusNotify;
  final double? latitude;
  final double? longitude;
  final dynamic mineCampaignCount;
  final dynamic countUnreadNotify;


  AppSettingsState copyWith(
      {
        dynamic hashtags,
        dynamic location,
        dynamic dataUser,
        dynamic dataPoint,
        AppSettingStatus? appSettingStatus,
        AppSettingStatusNotify? appSettingStatusNotify,
        final double? latitude,
        final double? longitude,
        dynamic countUnreadNotify,

        dynamic mineCampaignCount}) {
    return AppSettingsState(
        hashtags: hashtags ?? this.hashtags,
        dataUser: dataUser ?? this.dataUser,
        location: location ?? this.location,
        appSettingStatus: appSettingStatus ?? this.appSettingStatus,
        appSettingStatusNotify:
        appSettingStatusNotify ?? this.appSettingStatusNotify,
        dataPoint: dataPoint ?? this.dataPoint,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        mineCampaignCount: mineCampaignCount ?? this.mineCampaignCount,
        countUnreadNotify: countUnreadNotify ?? this.countUnreadNotify);
  }

  @override
  List<Object?> get props => [
    appSettingStatus,
    hashtags,
    location,
    dataPoint,
    latitude,
    dataUser,
    longitude,
    mineCampaignCount,
    countUnreadNotify,
    appSettingStatusNotify,

  ];
}