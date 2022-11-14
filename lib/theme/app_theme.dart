import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeping_time_mobile/theme/style.dart';

import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData themData = ThemeData(
    primarySwatch: AppColors.kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: GoogleFonts.robotoTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: rbtMedium(color: AppColors.black, fontSize: 14),
      toolbarTextStyle: rbtMedium(color: AppColors.black, fontSize: 14),
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: AppColors.kPrimaryColor),
      iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
      brightness: (Get.isDarkMode ? Brightness.dark : Brightness.light),
    ),
    // primaryTextTheme: GoogleFonts.notoSansTextTheme(),
    // accentTextTheme: GoogleFonts.notoSansTextTheme(),
  );
}
