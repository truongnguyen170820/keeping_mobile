import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import '../../routes/pages.dart';
import '../../utils/widget/select_image_picker_dialog.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? avatarFile;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteDark2,
      appBar: AppBar(
        title: Text(
          '프로필',
          style: rbtBold(color: AppColors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Pages.EDITPROFILE);
            },
            child: const Icon(Icons.settings, color: AppColors.black),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.centerLeft,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                  },
                  child: avatarFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(124.0),
                          child: Image(
                            image: FileImage(avatarFile!),
                            fit: BoxFit.cover,
                            height: 124,
                            width: 124,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'https://anhgaisexy.com/wp-content/uploads/2021/05/20210423-tieu-uyen-18-600x903.jpg',
                            height: 124,
                            width: 124,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            _buildItem("이름", "Nguyễn Đức Trưởng"),
            _buildItem("이메일 주소", "truongnd1708@gmail.com"),
            _buildItem("전화번호", "0346125367"),
            Spacer(),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 16),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16
                ),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Text('Log Out',
                    textAlign: TextAlign.center,
                    style: rbtBold(color: AppColors.colorRed, fontSize: 14)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String? name, String? detail) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.bgApp))),
      child: Row(
        children: [
          Text(
            name ?? '',
            style: rbtMedium(color: AppColors.black, fontSize: 14),
          ),
          const Spacer(),
          Text(
            detail ?? '',
            style: rbtBold(color: AppColors.black, fontSize: 14),
          )
        ],
      ),
    );
  }
}
