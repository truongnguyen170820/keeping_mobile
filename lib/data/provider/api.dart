//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../api_key_auth.dart';
import '../basic_auth.dart';

class Openapi {
  static const String basePath = r'http://localhost/api';
  final Dio dio;

  Openapi({
    Dio? dio,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  }) : this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: 5000,
              receiveTimeout: 3000,
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        BasicAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  Dio buildDio() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }
}
