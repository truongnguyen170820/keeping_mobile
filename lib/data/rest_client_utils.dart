import 'package:dio/dio.dart';
import 'package:keeping_time_mobile/data/provider/api.dart';
import 'package:keeping_time_mobile/data/provider/local_store/local_store.dart';
import '../common/constants.dart';
import '../common/interceptors/access_token_interceptor.dart';
import '../common/interceptors/logging_interceptor.dart';
import '../common/interceptors/unauthorized_interceptor.dart';
import 'provider/local_store/shared_preferences_local_store.dart';

class RestClientUtils {
  static Openapi initOpenapi() {
    LocalStore localStore = SharedPreferencesLocalStore();
    return Openapi(
      dio: Dio(
        BaseOptions(
          baseUrl: Constants.baseUrl,
          connectTimeout: Constants.connectTimeout,
          receiveTimeout: Constants.receiveTimeout,
        ),
      ),
      interceptors: [
        AccessTokenInterceptor(localStore: localStore),
        LoggingInterceptor(),
        UnauthorizedInterceptor(),
      ],
    );
  }
}
