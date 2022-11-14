import 'package:intl/intl.dart';

class DateTimeUtils {

  String formatTime(String? time) {
    var stape = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(time!);
    DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko');
    String timeFormat = dateFormat.format(stape.toLocal());
    return timeFormat;
  }
}