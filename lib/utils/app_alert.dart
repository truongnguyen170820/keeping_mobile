import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';

class AppAlert {
  static void showSuccess(FToast fToast, String message) {
    fToast.showToast(
        child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_user_outlined, color: Colors.white),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text(message,
                              style: rbtBold(
                                  color: AppColors.white, fontSize: 16))),
                    ],
                  )),
            )),
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: ScreenUtil().statusBarHeight + 15,
            left: 0,
          );
        });
  }

  static void showError(FToast fToast, String message) {
    fToast.showToast(
        child: Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      )
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.white),
                      SizedBox(width: 5),
                      Expanded(
                          child:
                              Text(message, style: rbtBold(
                                  color: AppColors.white, fontSize: 16))),
                    ],
                  )),
            )),
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: ScreenUtil().statusBarHeight + 15,
            left: 0,
          );
        });
  }
}
