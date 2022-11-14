part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

enum LogoutStatus { initial, loading, finish }

@immutable
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.logoutStatus = LogoutStatus.initial,
  });

  final AuthenticationStatus status;
  final LogoutStatus logoutStatus;

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    LogoutStatus? logoutStatus,
  }) {
    return AuthenticationState._(
      status: status ?? this.status,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        logoutStatus,
      ];
}
