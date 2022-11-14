import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const int _kPrimaryColor = 0xFF0065F2;

  static const MaterialColor kPrimaryColor = MaterialColor(
    _kPrimaryColor,
    <int, Color>{
      50: Color(0xFF7FE4FF),
      100: Color(0xFF66CBFF),
      200: Color(0xFF4DB2FF),
      300: Color(0xFF3398FF),
      400: Color(0xFF1A7FFF),
      500: Color(_kPrimaryColor),
      600: Color(0xFF004CD9),
      700: Color(0xFF0032BF),
      800: Color(0xFF0019A6),
      900: Color(0xFF00008C),
    },
  );

  static const Color white = Colors.white;
  static const Color whiteDark = Color(0xFFCCCCCC);
  static const Color bgApp = Color(0xFFF0F1F3);
  static const Color black = Colors.black;
  static const Color transparent = Color(0x00000000);
  static const Color green = Color(0xFF1FA990);
  static const Color BG = Color(0xFF009177);
  static const Color border = Color(0xFFA3DCD1);
  static const Color colorLightGreen = Color(0xFF39B300);
  static const Color colorOrange = Color(0xFFE85300);
  static const Color colorLightOrange = Color(0xFFFFD696);
  static const Color colorLightO = Color(0xFFFF9A00);
  static const Color whiteDark2 = Color(0xFFF0F1F3);
  static const Color colorText = Color(0xFF136758);
  static const Color colorIndicator = Color(0xFFDADEE2);
  static const Color colorIndicatorOften = Color(0xFF9C5E00);
  static const Color colorGrey = Color(0xFFBCC3CC);
  static const Color colorBlackText = Color(0xFF2D343D);
  static const Color colorBlack8 = Color(0xFF475261);
  static const Color colorGreen1 = Color(0xFF236D00);
  static const Color colorRed1 = Color(0xFF8E3300);
  static const Color colorRed = Color(0xFFFC0808);

}
