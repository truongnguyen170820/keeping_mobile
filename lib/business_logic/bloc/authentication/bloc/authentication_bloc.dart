import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/provider/local_store/local_store.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required LocalStore localStore})
      : _localStore = localStore,
        super(const AuthenticationState.unknown());

  final LocalStore _localStore;
  bool onLoggingOut = false;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogout) {
      yield* _mapAuthenticationLogoutToState(event);
    } else if (event is CheckSaveAccountLogged) {
      yield* _mapCheckSaveAccountLoggedToState(event);
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        return const AuthenticationState.authenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Stream<AuthenticationState> _mapCheckSaveAccountLoggedToState(
      CheckSaveAccountLogged event) async* {
    bool isSave = await _localStore.getSaveOrNotCredentials();
    print('isSave $isSave');

    if (!isSave) {
      add(AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLogoutToState(
      AuthenticationLogout event) async* {
    if (onLoggingOut) {
      return;
    }
    onLoggingOut = true;
    yield state.copyWith(logoutStatus: LogoutStatus.loading);
    try {
      // String accessToken = await _localStore.getAccessToken();
      // if (accessToken.isNotEmpty) {
      //   await _accountRepos.logout();
      // }
      yield state.copyWith(logoutStatus: LogoutStatus.finish);
    } catch (e) {
      yield state.copyWith(logoutStatus: LogoutStatus.finish);
    }
    try {} catch (e) {
    } finally {
      add(AuthenticationStatusChanged(AuthenticationStatus.unauthenticated));
      onLoggingOut = false;
    }
  }
}
