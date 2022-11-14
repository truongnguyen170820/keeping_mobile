part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

@immutable
class LoginState extends BaseBlocState {
  const LoginState({
    this.loginStatus = LoginStatus.initial,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final LoginStatus loginStatus;

  LoginState copyWith({LoginStatus? loginStatus, ResponseError? error}) {
    return LoginState(
        loginStatus: loginStatus ?? this.loginStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [loginStatus];
}
