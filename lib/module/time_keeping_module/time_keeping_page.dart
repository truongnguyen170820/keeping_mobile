import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import 'package:keeping_time_mobile/utils/format_date.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../routes/pages.dart';

class TimeKeepingPage extends StatefulWidget {
  const TimeKeepingPage({Key? key}) : super(key: key);

  @override
  State<TimeKeepingPage> createState() => _TimeKeepingPageState();
}

class _TimeKeepingPageState extends State<TimeKeepingPage> {
  @override
  void initState() {
    initializeDateFormatting();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Scaffold _buildContent(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUser(),
              Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                    "${DateTimeUtils().formatTime(date.toIso8601String())}",
                    style: rbtBold(color: AppColors.black, fontSize: 16)),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.bgApp,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.whiteDark)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_buildTime(), _buildQR(), _buildOvertime()],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 22,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Pages.REPORT);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ]),
                child: Assets.icons.editSquare.image(height: 24, width: 24),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildUser() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 24,
          right: 16,
          left: 16),
      color: AppColors.BG,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl:
                  'https://anhgaisexy.com/wp-content/uploads/2021/05/20210423-tieu-uyen-18-600x903.jpg',
              height: 65,
              width: 65,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nguyễn Đức Trưởng",
                  style: rbtBold(color: AppColors.white, fontSize: 20)),
              Text(
                "Dev",
                style: rbtRegularNormal(color: AppColors.white, fontSize: 12),
              )
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            child: Badge(
              padding: EdgeInsets.all(2),
              badgeContent: Text('10',
                  style: rbtMedium(color: AppColors.white, fontSize: 10)),
              child: Assets.icons.notify.image(height: 20, width: 20),
            ),
          ),
        ],
      ),
    );
  }

  _buildTime() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.white,
          border: Border.all(color: Colors.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Assets.icons.timeIn.image(width: 18, height: 18),
                  SizedBox(width: 4),
                  Text("출근",
                      style: rbtMedium(
                          color: AppColors.colorLightGreen, fontSize: 14)),
                ],
              ),
              Text(
                "09:00:00",
                style: rbtBold(color: AppColors.black, fontSize: 20),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 36),
            color: AppColors.whiteDark,
            width: 1,
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Assets.icons.timeOut.image(width: 18, height: 18),
                  SizedBox(width: 4),
                  Text("출근",
                      style: rbtMedium(
                          color: AppColors.colorOrange, fontSize: 14)),
                ],
              ),
              Text("18:00:00",
                  style: rbtBold(color: AppColors.black, fontSize: 20))
            ],
          )
        ],
      ),
    );
  }

  _buildQR() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Pages.QRPAGE);
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ], shape: BoxShape.circle, color: AppColors.green),
          padding: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 45, horizontal: 22),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
            child: Text(
              'QR체크',
              style: rbtBold(color: AppColors.green, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  _buildOvertime() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.colorLightOrange),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(100),
          color: AppColors.white),
      child: Row(
        children: [
          Assets.icons.timeCircle.image(width: 24, height: 24),
          SizedBox(width: 6),
          Text('시간 외에', style: rbtMedium(color: AppColors.black, fontSize: 14)),
          Spacer(),
          Text("00:00:00",
              style: rbtBold(color: AppColors.colorLightO, fontSize: 16))
        ],
      ),
    );
  }
}
