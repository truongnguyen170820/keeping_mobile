import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../rest_client_utils.dart';
import '../api.dart';
import 'campain_provider.dart';

class ApiCampaignProvider extends CampaignProvider {
  ApiCampaignProvider();

  Openapi api = RestClientUtils.initOpenapi();

  @override
  Future report({String? topic, String? content}) async {
    // TODO: implement report
    throw UnimplementedError();
  }

  @override
  Future checkIn({String? idUse, String? dateCheck, String? timeIn}) {
    // TODO: implement checkIn
    throw UnimplementedError();
  }

  @override
  Future listKeepingMonth({
    int? limit,
    int? offset,
    String? idUser,
    String? month,
    String? year,
  }) async {
    Response response = await api.buildDio().get(
        '/dev_green/api/user/get_list_month',
        queryParameters: <String, dynamic>{
          'limit': limit,
          'offset': offset ?? 0,
          'm_user_id': idUser,
          'month': month,
          'year': year
        });
    return response.data['list'];
  }

  @override
  Future listKeepingWeek(
      {int? limit,
      int? offset,
      String? idUser,
      String? dateBegin,
      String? dateEnd}) async {
    Response response = await api.buildDio().get(
        '/dev_green/api/user/get_list_week',
        queryParameters: <String, dynamic>{
          'limit': limit,
          'offset': offset ?? 0,
          'm_user_id': idUser,
          'date_begin_week': dateBegin,
          'date_end_week': dateEnd,
        });
    return response.data['list'];
  }
}
