part of 'home_bloc.dart';

enum HomeStatus { home, schedule, profile }

@immutable
class HomeState extends BaseBlocState {
  HomeState({
    this.homeStatus = HomeStatus.home,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final HomeStatus homeStatus;

  HomeState copyWith({HomeStatus? homeStatus, ResponseError? error}) {
    return HomeState(
        homeStatus: homeStatus ?? this.homeStatus, error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [homeStatus];
}
