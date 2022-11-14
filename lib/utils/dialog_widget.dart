import 'package:flutter/material.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/theme/style.dart';

import '../theme/app_colors.dart';

class AppAlertDialog extends StatefulWidget {
  const AppAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    this.onCloseTap,
    this.barrierDismissible = true,
  });

  final String title;
  final String message;
  final bool barrierDismissible;
  final VoidCallback? onCloseTap;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onCloseTap,
    bool? barrierDismissible,
  }) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (buildContext, animation, secondaryAnimation) {
          return AppAlertDialog(
            title: title,
            message: message,
            onCloseTap: onCloseTap,
          );
        });
  }

  @override
  _AppAlertDialogState createState() => _AppAlertDialogState();
}

class _AppAlertDialogState extends State<AppAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              // padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 30.0,
                    offset: const Offset(0.0, 20.0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          Text('2022년 7월 급여',
                              style: rbtMedium(
                                  color: AppColors.black, fontSize: 20)),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              }, child: Assets.icons.close.image(width: 24 , height: 24))
                        ],
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('기본 급여 (26일)', style: rbtMedium(color: AppColors.colorBlack8, fontSize: 14)),
                          Text('10.000.000 VND', style: rbtBold(color: AppColors.colorBlack8, fontSize: 16))
                        ],
                      ),
                      Divider(color: AppColors.colorGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('시간 외에 (20시간)', style: rbtMedium(color: AppColors.colorBlack8, fontSize: 14)),
                          Text('+3.000.000 VND', style: rbtBold(color: AppColors.colorGreen1, fontSize: 14))
                        ],
                      ),
                      Divider(color: AppColors.colorGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('무급휴일', style: rbtMedium(color: AppColors.colorBlack8, fontSize: 14)),
                          Text('-   400.000 VND', style: rbtBold(color: AppColors.colorRed1, fontSize: 14))
                        ],
                      ),
                      Divider(color: AppColors.colorGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('늦출 (20분)', style: rbtMedium(color: AppColors.colorBlack8, fontSize: 14)),
                          Text('-   150.000 VND', style: rbtBold(color: AppColors.colorRed1, fontSize: 14))
                        ],
                      ),
                      Divider(color: AppColors.colorGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('실제로 받은 월급', style: rbtMedium(color: AppColors.colorBlack8, fontSize: 14)),
                          Text('11.870.000 VND', style: rbtBold(color: AppColors.green, fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
