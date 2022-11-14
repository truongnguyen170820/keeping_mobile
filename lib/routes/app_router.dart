import 'package:flutter/material.dart';
import 'package:keeping_time_mobile/module/edit_my_module/edit_my_page.dart';
import 'package:keeping_time_mobile/module/login_module/login_page.dart';
import 'package:keeping_time_mobile/module/qr_module/qr_page.dart';
import '../module/add_profile_module/profile_page.dart';
import '../module/company_module/company_page.dart';
import '../module/holiday_module/holiday_page.dart';
import '../module/home_module/home_page.dart';
import '../module/register_module/register_page.dart';
import '../module/report_page_module/report_page.dart';
import '../module/splash_module/splash_page.dart';
import 'pages.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  // ignore: missing_return
  Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.SPLASH:
        return SplashPage.route();
      case Pages.HOME:
        return HomePage.route();
      case Pages.LOGIN:
        return LoginPage.route();
      case Pages.REGISTER:
        return RegisterPage.route();
      case Pages.HOLIDAY:
      return HolidayPage.route();
      case Pages.REPORT:
        return ReportPage.route();
      case Pages.QRPAGE:
        return QRPage.route();
      case Pages.COMPANY:
        return CompanyPage.route();
      case Pages.EDITPROFILE:
        return EditMyPage.route();
      case Pages.PROFILE:
        return ProfilePage.route();
    }
  }
}
