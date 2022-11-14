import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import '../../theme/style.dart';

class SelectImgPickerDialog extends StatefulWidget {
  const SelectImgPickerDialog({
    Key? key,
    this.openCameraTap,
    this.chooseImgTap,
  });

  final Function? openCameraTap;
  final Function? chooseImgTap;

  static void show(BuildContext context,
      {Function? openCameraTap, Function? chooseImgTap, Function? cancelTap}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black.withOpacity(0.7),
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (buildContext, animation, secondaryAnimation) {
          return SelectImgPickerDialog(
            openCameraTap: openCameraTap,
            chooseImgTap: chooseImgTap,
          );
        });
  }

  @override
  _SelectImgPickerDialogState createState() => _SelectImgPickerDialogState();
}

class _SelectImgPickerDialogState extends State<SelectImgPickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            left: 0,
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24))),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,

                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (widget.openCameraTap != null) {
                          widget.openCameraTap!();
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            Assets.icons.cameraChat
                                .image(height: 24, width: 24),
                            const SizedBox(width: 5),
                            Text(
                              "사진촬영",
                              style:
                                  rbtMedium(color: Colors.black, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (widget.chooseImgTap != null) {
                          widget.chooseImgTap!();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.only(top: 5),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Assets.icons.line.image(height: 24, width: 24),
                            const SizedBox(width: 5),
                            Text(
                              "사진첨부",
                              style:
                                  rbtMedium(color: Colors.black, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: ScreenUtil().screenWidth,
                        child: Text(
                          '취소',
                          style: rbtMedium(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                )))
      ],
    );
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);
