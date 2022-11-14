part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {}

class RegisterApp extends RegisterEvent {
  RegisterApp({this.email, this.password, this.confirmPassword});

  final String? email;
  final String? password;
  final String? confirmPassword;

  @override
  // TODO: implement props
  List<Object?> get props => [password, email, confirmPassword];
}
