import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../common/api_response_error.dart';
import '../../../common/base_bloc_state.dart';
import '../../../common/response_error.dart';
import '../../../data/provider/account_provider/account_provider.dart';

part 'company_event.dart';

part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc({
    required AccountProvider accountProvider,
  })  : _accountProvider = accountProvider,
        super(CompanyState());

  final AccountProvider _accountProvider;

  @override
  Stream<CompanyState> mapEventToState(CompanyEvent event) async* {
    if (event is CompanyApp) {
      yield* _mapLoginState(event);
    }
  }

  Stream<CompanyState> _mapLoginState(CompanyApp event) async* {
    yield state.copyWith(companyStatus: CompanyStatus.loading);
    if (event.nameCompany != null && event.nameCompany!.isEmpty) {
      yield state.copyWith(
        companyStatus: CompanyStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing name company!')),
      );
    } else if (event.nameAddressCompany != null &&
        event.nameAddressCompany!.isEmpty) {
      yield state.copyWith(
        companyStatus: CompanyStatus.failure,
        error: ResponseError.bindResponseError(
            ApiResponseError(message: 'Missing address company!')),
      );
    } else {
      try {
        await _accountProvider.login(
            email: event.nameAddressCompany, password: event.nameCompany);
        yield state.copyWith(companyStatus: CompanyStatus.success);
      } catch (e) {
        yield state.copyWith(
            companyStatus: CompanyStatus.failure,
            error: ResponseError.bindResponseError(e));
      }
    }
  }
}
