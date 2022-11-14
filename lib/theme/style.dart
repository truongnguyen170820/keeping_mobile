import 'package:flutter/material.dart';


/// font text

TextStyle rbtRegularNormal({required Color color, required double fontSize}) =>
    TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "NotoSansKR-Regular",
        wordSpacing: 2,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal);

TextStyle rbtRegularNormalUnderline(
    {required Color color, required double fontSize}) =>
    TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "NotoSansKR-Regular",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.underline);

TextStyle rbtMedium({required Color color, required double fontSize}) =>
    TextStyle(
      color: color,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: "NotoSansKR-Medium",
      fontSize: fontSize,
    );

TextStyle rbtMediumUnderline(
    {required Color color, required double fontSize}) =>
    TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: "NotoSansKR-Regular",
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline);

TextStyle rbtBold({required Color color, required double fontSize}) =>
    TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontFamily: "NotoSansKR-Bold",
      fontSize: fontSize,
    );