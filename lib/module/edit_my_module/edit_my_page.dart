import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field_my.dart';
import '../../utils/widget/select_image_picker_dialog.dart';

class EditMyPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const EditMyPage());
  }

  const EditMyPage({Key? key}) : super(key: key);

  @override
  State<EditMyPage> createState() => _EditMyPageState();
}

class _EditMyPageState extends State<EditMyPage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  File? avatarFile;

  bool wifi = false;
  bool gps = false;

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필',
          style: rbtBold(color: AppColors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.icons.back.image(width: 22, height: 22),
          ),
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 220),
              Container(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _onSelectImage(context);
                    },
                    child: avatarFile != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(124.0),
                                child: Image(
                                  image: FileImage(avatarFile!),
                                  fit: BoxFit.cover,
                                  height: 124,
                                  width: 124,
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Assets.icons.cameraGreen.image(
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  'https://anhgaisexy.com/wp-content/uploads/2021/05/20210423-tieu-uyen-18-600x903.jpg',
                                  height: 124,
                                  width: 124,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Assets.icons.cameraGreen.image(
                                  height: 32,
                                  width: 32,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomTextFieldMy(
                label: "이름",
                borderRadius: 100,
                controller: nameCtrl,
                icon: Assets.icons.profile.image(height: 24, width: 24),
                // customIcon: CupertinoButton(
                //   onPressed: () {},
                //   child: Assets.icons.edit.image(width: 20, height: 20),
                // ),
              ),
              SizedBox(height: 16),
              CustomTextFieldMy(
                label: "이메일 주소",
                borderRadius: 100,
                icon: Assets.icons.message.image(height: 24, width: 24),
                controller: emailCtrl,
                // customIcon: CupertinoButton(
                //   onPressed: () {},
                //   child: Assets.icons.edit.image(width: 20, height: 20),
                // ),
              ),
              SizedBox(height: 16),
              CustomTextFieldMy(
                label: "전화번호",
                borderRadius: 100,
                icon: Assets.icons.call.image(height: 24, width: 24),
                controller: phoneCtrl,
                // customIcon: CupertinoButton(
                //   onPressed: () {},
                //   child: Assets.icons.edit.image(width: 20, height: 20),
                // ),
              ),
              SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
                color: AppColors.BG
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                child: Text('Save',
                    textAlign: TextAlign.center,
                    style: rbtMedium(color: AppColors.white, fontSize: 14)),
              )
              // Text('액세스 권한 부여',
              //     style: rbtBold(color: AppColors.black, fontSize: 18)),
              // SizedBox(height: 16),
              // Row(
              //   children: [
              //     Assets.icons.wifi.image(height: 24, width: 24),
              //     SizedBox(width: 12),
              //     Text('Wifi',
              //         style: rbtMedium(color: AppColors.black, fontSize: 16)),
              //     Spacer(),
              //     CupertinoSwitch(
              //         value: wifi,
              //         thumbColor: AppColors.white,
              //         activeColor: AppColors.green,
              //         onChanged: (value) {
              //           setState(() {
              //             wifi = value;
              //           });
              //         })
              //   ],
              // ),
              // Divider(
              //   height: 25,
              // ),
              // Row(
              //   children: [
              //     Assets.icons.location.image(height: 24, width: 24),
              //     SizedBox(width: 12),
              //     Text('GPS',
              //         style: rbtMedium(color: AppColors.black, fontSize: 16)),
              //     Spacer(),
              //     CupertinoSwitch(
              //         value: gps,
              //         thumbColor: AppColors.white,
              //         activeColor: AppColors.green,
              //         onChanged: (value) {
              //           setState(() {
              //             gps = value;
              //           });
              //         })
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectImage(BuildContext context) {
    SelectImgPickerDialog.show(context, chooseImgTap: () {
      _onPickPhoto(ImageSource.gallery);
    }, openCameraTap: () {
      _onPickPhoto(ImageSource.camera);
    });
  }

  void _onPickPhoto(ImageSource source) async {
    try {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: source,
        imageQuality: 50,
        maxHeight: 300,
        maxWidth: 300,
      );
      if (pickedFile != null) {
        setState(() {
          avatarFile = File(pickedFile.path);
        });
      }
    } catch (e) {}
  }
}
