part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LoginApp extends LoginEvent {
  LoginApp({this.email, this.password});

  final String? email;
  final String? password;

  @override
  // TODO: implement props
  List<Object?> get props => [password, email];
}

class SaveAutoLoginStatusEvent extends LoginEvent {
  SaveAutoLoginStatusEvent({required this.status});
  bool status;

  @override
  List<Object?> get props => [status];
}
