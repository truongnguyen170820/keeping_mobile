part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

@immutable
class ProfileState extends BaseBlocState {
  const ProfileState({
    this.profileStatus = ProfileStatus.initial,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final ProfileStatus profileStatus;

  ProfileState copyWith({ProfileStatus? profileStatus, ResponseError? error}) {
    return ProfileState(
        profileStatus: profileStatus ?? this.profileStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [profileStatus];
}
