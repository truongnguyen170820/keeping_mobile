// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return ApiError(
    statusCode: json['statusCode'] as int?,
    name: json['name'] as String?,
    message: json['message'] as String?,
    code: json['code'] as String?,
    stack: json['stack'] as String?,
  );
}

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'name': instance.name,
      'message': instance.message,
      'code': instance.code,
      'stack': instance.stack,
    };
