import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'api_error.dart';
import 'app_converter.dart';

class ApiResponseError extends Equatable {
  final String? code;
  final String? message;

  @AppConverter()
  final ApiError? error;

  ApiResponseError({this.code, this.message, this.error});

  ApiResponseError copyWith({
    String? code,
    String? message,
    ApiError? error,
  }) {
    return ApiResponseError(
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [code, message, error];

  static ApiResponseError bindApiResponseError(DioError error) {
    print(error.error);
    ApiResponseError response = ApiResponseError(
        code: '${error.response?.statusCode}',
        message: error.response?.statusMessage);
    if (error.response != null &&
        error.response?.data != null &&
        error.response?.data is Map<String, dynamic> &&
        error.response?.data['error'] != null) {
      response = response.copyWith(
          error: ApiError.fromJson(error.response?.data['error']));
    }
    if (error.type == DioErrorType.response) {
      if (error.response?.statusCode == 500 ||
          error.response?.statusCode == 404) {
        response = response.copyWith(message: error.response?.statusMessage);
      }
    } else if (error.error != null && error.error is SocketException) {
      response = response.copyWith(code: '500');
    }

    return response;
  }
}
