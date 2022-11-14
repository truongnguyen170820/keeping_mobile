import 'package:dio/dio.dart';
import 'package:keeping_time_mobile/data/provider/local_store/local_store.dart';


class AccessTokenInterceptor extends Interceptor {
  AccessTokenInterceptor({required this.localStore});

  final LocalStore localStore;

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = '';
    if (token.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $token';
      options.queryParameters.addAll(<String, dynamic>{'access_token': 'Bearer $token'});
    }
    return super.onRequest(options, handler);
  }
}
