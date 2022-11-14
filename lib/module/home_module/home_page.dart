import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/module/home_module/bloc/home_bloc.dart';
import 'package:keeping_time_mobile/module/my_module/my_page.dart';
import 'package:keeping_time_mobile/module/time_keeping_module/time_keeping_page.dart';
import 'package:keeping_time_mobile/module/timekeeping_process_module/timekeeping_process_page.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';

class HomePage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with GlobalKeyStateMixin {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Scaffold _buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Stack(
            children: [
              IndexedStack(
                index: currentIndex,
                children: [
                  TimeKeepingPage(),
                  TimekeepingProcessPage(),
                  MyPage(),
                ],
              )
            ],
          ),
        ),
        extendBody: true,
        key: globalKey,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (indexClicked) {
              setState(() {
                currentIndex = indexClicked;
              });
            },
            selectedIconTheme: const IconThemeData(color: Colors.white),
            selectedItemColor: AppColors.green,
            selectedLabelStyle: rbtBold(color: AppColors.green, fontSize: 14),
            items: [
              BottomNavigationBarItem(
                  icon: currentIndex == 0
                      ? Assets.icons.home.image(height: 24, width: 24)
                      : Assets.icons.home_grey.image(height: 24, width: 24),
                  label: "홈페이지 "),
              BottomNavigationBarItem(
                  icon: currentIndex != 1
                      ? Assets.icons.document.image(height: 24, width: 24)
                      : Assets.icons.documentGreen.image(height: 24, width: 24),
                  label: "일정"),
              BottomNavigationBarItem(
                  icon: currentIndex != 2
                      ? Assets.icons.profile.image(height: 24, width: 24)
                      : Assets.icons.profileGreen.image(height: 24, width: 24),
                  label: "프로필"),
            ]));
  }

  void _listenFetchData(BuildContext context, HomeState state) {
    // if (state.homeStatus == HomeStatus.profile) {
    //   return;
    // }
    //
    // if (state.homeStatus == HomeStatus.schedule) {
    //   return;
    // }
    //
    // if (state.homeStatus == HomeStatus.home) {
    //   setState(() {});
    //   return;
    // }
  }
}
