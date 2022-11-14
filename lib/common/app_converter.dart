import 'package:json_annotation/json_annotation.dart';

import 'api_error.dart';

class AppConverter<T> implements JsonConverter<T?, Map<String, dynamic>?> {
  const AppConverter();

  @override
  T? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    if (T == ApiError) {
      return ApiError.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Map<String, dynamic>? toJson(T? object) {
    if (object == null) {
      return null;
    }
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object as Map<String, dynamic>;
  }
}
