import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeping_time_mobile/translations/vi_VN.dart';

import 'en_US.dart';

class AppTranslation {
  AppTranslation._();

  static final Locale locale = Get.deviceLocale!;
  static final Map<String, Map<String, String>> translations = {
    'en': en_US,
    'vi': vi_VN,
  };
}
