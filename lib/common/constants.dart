import 'package:intl/intl.dart';

class Constants {
  static const String baseUrl = 'http://43.200.20.68:3000/api/v1';
  static const String baseStatic = 'http://43.200.20.68:3000/api/v1';
  static const String login = "auth/login";
  static const String user = "userdata";

  static const Duration timeout = Duration(seconds: 30);

  static const String TOKEN = 'authToken';
  static const String HIVE_BOX = 'hiveBox';
  static const int LIMIT_DATA = 10;

  static const String ALL = '전체';
  static const bool loggingInterceptorEnabled = true;
  static const int connectTimeout = 10000; // 10 seconds
  static const int receiveTimeout = 10000; // 10 seconds

  static const String INVALID_PHONE_NUMBER = 'invalid-phone-number';

  static String formatMoney(dynamic number, {String suffix = "원"}) {
    final oCcy = NumberFormat("#,##0", "en-US");
    return oCcy.format(number) + suffix;
  }
}

enum WORK { date, go_to_work, leave_work, total_work_time, work_status }

class WORK_TYPE_TEXT {
  static const date = '날짜';
  static const go_to_work = '출근';
  static const leave_work = '퇴근';
  static const total_work_time = '총 작업 시간';
  static const work_status = '광고 문의';
}

const DATA_PERSONNEL = [
  {"name": "Manage"},
  {"name": "Interpreters"},
  {"name": "Customer Care"},
  {"name": "Developer"},
  {"name": "Tester"},
];

const DATA_VACATION = [
  {"name": "유급휴일"},
  {"name": "무급휴일"}
];
