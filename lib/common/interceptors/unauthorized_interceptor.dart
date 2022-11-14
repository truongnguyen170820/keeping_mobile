import 'package:dio/dio.dart';
import '../constants.dart';
import '../events/rx_events.dart';

class UnauthorizedInterceptor extends Interceptor {
  UnauthorizedInterceptor();

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   print('UnauthorizedInterceptor ${response.statusCode}');
  //   if (response.statusCode == 401) {
  //     // send notify not authorized
  //     RxBus.post(UnauthenticatedEvent());
  //   }
  //   return handler.next(response);
  // }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // send notify not authorized
      // RxBus.post(UnauthenticatedEvent(), tag: Constants.unauthenticatedEvent);
    }
    super.onError(err, handler);
  }
}
