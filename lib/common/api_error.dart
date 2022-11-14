import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError extends Equatable {
  final int? statusCode;
  final String? name;
  final String? message;
  final String? code;
  final String? stack;

  ApiError({
    this.statusCode,
    this.name,
    this.message,
    this.code,
    this.stack,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  @override
  List<Object?> get props => [
        statusCode,
        name,
        message,
        stack,
        code
      ];
}

class ErrorType {
}
