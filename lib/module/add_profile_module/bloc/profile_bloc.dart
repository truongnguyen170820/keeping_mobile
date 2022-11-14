import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../common/api_response_error.dart';
import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';
import '../../../data/provider/account_provider/account_provider.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required AccountProvider accountProvider,
  })  : _accountProvider = accountProvider,
        super(ProfileState());

  final AccountProvider _accountProvider;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileApp) {
      yield* _mapProfileState(event);
    }
  }

  Stream<ProfileState> _mapProfileState(ProfileApp event) async* {
    yield state.copyWith(profileStatus: ProfileStatus.loading);
    if (event.avatar != null && event.avatar!.isEmpty) {
      yield state.copyWith(
        profileStatus: ProfileStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Please upload profile picture!')),
      );
    } else if (event.name != null && event.name!.isEmpty) {
      yield state.copyWith(
        profileStatus: ProfileStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing name!')),
      );
    } else if (event.idCard != null && event.idCard!.isEmpty) {
      yield state.copyWith(
        profileStatus: ProfileStatus.failure,
        error: ResponseError.bindResponseError(ApiResponseError(
            message: 'Please upload a photo of your Identification')),
      );
    } else {
      try {
        await _accountProvider.login(
            email: event.birthday, password: event.birthday);
        yield state.copyWith(profileStatus: ProfileStatus.success);
      } catch (e) {
        yield state.copyWith(
            profileStatus: ProfileStatus.failure,
            error: ResponseError.bindResponseError(e));
      }
    }
  }
}
