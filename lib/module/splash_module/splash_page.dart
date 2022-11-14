import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../gen/assets.gen.dart';
import '../../routes/pages.dart';
import '../../theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => SplashPage());
  }

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _gotoHomePage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Assets.images.logo
              .image(height: Get.size.width * 0.5, width: Get.size.width * 0.5),
        ),
      ),
    );
  }

  _gotoHomePage() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushNamedAndRemoveUntil(
      Pages.LOGIN,
          (route) => false,
    );
  }
}
