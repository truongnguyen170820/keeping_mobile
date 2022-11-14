import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import 'api_response_error.dart';

class ResponseError extends Equatable {
  final String? errorKey; // AppLocalizations.of(context).translate(errorCode)
  final String? code;
  final String? message;

  const ResponseError({this.errorKey, this.code, this.message});

  ResponseError copyWith({
    String? errorKey,
    String? code,
    String? message,
  }) {
    return ResponseError(
      errorKey: errorKey ?? this.errorKey,
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [errorKey, code, message];

  static ResponseError? bindResponseError(Object error) {
    try {
      if (error is ApiResponseError) {
        return ResponseError(
          errorKey: error.error != null
              ? (error.error!.code ?? '')
              : (error.code == '500' ? 'ERROR_CONNECT_SERVER' : null),
          code: error.code,
          message: error.message,
        );
      } else {
        if (error is DioError) {
          if (error.type == DioErrorType.connectTimeout) {
            return ResponseError(
              errorKey: 'TIME_OUT',
            );
          }
          if (error.type == DioErrorType.response) {
            return ResponseError(message: error.response!.data['message']);
          }
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
