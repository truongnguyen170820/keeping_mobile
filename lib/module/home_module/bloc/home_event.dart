part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class NextPage extends HomeEvent {
  NextPage({
    this.homeStatus
  });

  final HomeStatus? homeStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [homeStatus];
}