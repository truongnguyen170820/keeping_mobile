import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../rest_client_utils.dart';
import '../api.dart';
import 'account_provider.dart';

class ApiAccountProvider extends AccountProvider {
  ApiAccountProvider();

  Openapi api = RestClientUtils.initOpenapi();

  @override
  Future login({String? email, String? password}) async {
    Map<String, dynamic> _body = {"email": email, 'password': password};
    Response result = await api.buildDio().post('/auth/login', data: _body);
    return result.data['data'];
  }

  @override
  Future userDetail({String? idUser}) async {
    Response response =
        await api.buildDio().get('/dev_green/api/user/detail/$idUser');
    return response;
  }

  @override
  Future userUpdate(
      {String? idUser,
      String? userName,
      String? mailUser,
      String? phoneNumber}) async {
    await api.buildDio().put('/auth/profile', data: <String, dynamic>{
      'm_user_id': idUser,
      'user_name': userName,
      'mail_address': mailUser,
      'phone': phoneNumber
    });
    return;
  }
}
