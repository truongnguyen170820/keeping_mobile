import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../common/api_response_error.dart';
import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';
import '../../../data/provider/account_provider/account_provider.dart';
import '../../../data/provider/local_store/local_store.dart';

part 'login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc( {
    required LocalStore localStore,
    required AccountProvider accountProvider,
  })  : _accountProvider = accountProvider,
        _localStore = localStore,
        super(LoginState());

  final AccountProvider _accountProvider;
  final LocalStore _localStore;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginApp) {
      yield* _mapLoginState(event);
    } else if (event is SaveAutoLoginStatusEvent) {
      yield* _mapSaveAutoLoginStatusToState(event);
    }
  }

  Stream<LoginState> _mapLoginState(LoginApp event) async* {
    yield state.copyWith(loginStatus: LoginStatus.loading);
    if (event.email != null && event.email!.isEmpty) {
      yield state.copyWith(
        loginStatus: LoginStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing email!')),
      );
    } else if (event.password != null && event.password!.isEmpty) {
      yield state.copyWith(
        loginStatus: LoginStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing password!')),
      );
    } else {
      try {
        await _accountProvider.login(
            email: event.email, password: event.password);
        yield state.copyWith(loginStatus: LoginStatus.success);
      } catch (e) {
        yield state.copyWith(
            loginStatus: LoginStatus.failure,
            error: ResponseError.bindResponseError(e));
      }
    }
  }

  Stream<LoginState> _mapSaveAutoLoginStatusToState(
      SaveAutoLoginStatusEvent event) async* {
    await _localStore.setSaveOrNotCredentials(event.status);
  }
}
