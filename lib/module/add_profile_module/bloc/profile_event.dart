part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileApp extends ProfileEvent {
  ProfileApp(
      {this.name, this.phoneNumber, this.birthday, this.idCard, this.avatar});

  final String? name;
  final String? birthday;
  final String? phoneNumber;
  final List<File>? avatar;
  final List<File>? idCard;

  @override
  // TODO: implement props
  List<Object?> get props => [name, birthday, phoneNumber, avatar, idCard];
}
