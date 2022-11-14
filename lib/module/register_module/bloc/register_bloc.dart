
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../common/api_response_error.dart';
import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';
import '../../../data/provider/account_provider/account_provider.dart';

part 'register_state.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  RegisterBloc( {
    // required LocalStore localStore,
    required AccountProvider accountProvider,
  })  : _accountProvider = accountProvider,
        // _localStore = localStore,
        super(RegisterState());

  final AccountProvider _accountProvider;

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterApp) {
      yield* _mapRegisterState(event);
    }
  }

  Stream<RegisterState> _mapRegisterState(RegisterApp event) async* {
    yield state.copyWith(registerStatus: RegisterStatus.loading);
    if (event.email != null && event.email!.isEmpty) {
      yield state.copyWith(
        registerStatus: RegisterStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing email!')),
      );
    } else if (event.password != null && event.password!.isEmpty) {
      yield state.copyWith(
        registerStatus: RegisterStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing password!')),
      );
    }else if (event.confirmPassword != null && event.confirmPassword!.isEmpty) {
      yield state.copyWith(
        registerStatus: RegisterStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing confirm password!')),
      );
    } else {
      try {
        await _accountProvider.login(
            email: event.email, password: event.password);
        yield state.copyWith(registerStatus: RegisterStatus.success);
      } catch (e) {
        yield state.copyWith(
            registerStatus: RegisterStatus.failure,
            error: ResponseError.bindResponseError(e));
      }
    }
  }

}