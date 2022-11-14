import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/module/add_profile_module/bloc/profile_bloc.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field.dart';

import '../../common/easy_loading.dart';
import '../../data/provider/account_provider/account_provider.dart';
import '../../gen/assets.gen.dart';
import '../../routes/pages.dart';
import '../../theme/app_colors.dart';
import '../../theme/style.dart';
import '../../utils/app_alert.dart';
import '../../utils/widget/select_image_picker_dialog.dart';

class ProfilePage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => ProfilePage());
  }

  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with GlobalKeyStateMixin {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController birthdayCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  bool checkBox = false;
  List<File> filesAvatar = [];
  List<File> filesIdCard = [];

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(
              accountProvider: context.read<AccountProvider>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) =>
                  previous.profileStatus != current.profileStatus,
              listener: _listenFetchData,
            ),
          ],
          child: _buildContent(context),
        ));
  }

  Scaffold _buildContent(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Assets.icons.back.image(width: 32, height: 32),
          ),
        ),
        title:
            Text('프로필', style: rbtBold(color: AppColors.black, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                '앱에 작업 과정을 기록할 수 있도록 정확한 개인 정보를 제공해주세요',
                style: rbtMedium(color: AppColors.black, fontSize: 14),
                textScaleFactor: 1.1,
              ),
              SizedBox(height: 24),
              GestureDetector(
                  onTap: () {
                    _addImages();
                  },
                  child: Assets.images.pickImage.image()),
              SizedBox(height: 16),
              if (filesAvatar != []) ...{
                Wrap(
                  spacing: 12,
                  children: List.generate(
                      filesAvatar.length,
                      (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              filesAvatar[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          )),
                ),
                SizedBox(height: 16),
              },
              CustomTextField(
                controller: nameCtrl,
                icon: Assets.icons.profile.image(height: 24, width: 24),
                colorBorder: true,
                hintText: '이름을 입력해주세요',
                label: '이름',
                labelColor: '*',
              ),
              SizedBox(height: 16),
              Text(
                'ID Card ',
                style: rbtMedium(color: AppColors.black, fontSize: 18),
              ),
              SizedBox(height: 16),
              GestureDetector(
                  onTap: () {
                    _addImagesIdCard();
                  },
                  child: Assets.images.idCard.image()),
              SizedBox(height: 16),
              if (filesIdCard != []) ...{
                Wrap(
                  spacing: 12,
                  children: List.generate(
                      filesIdCard.length,
                      (index) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              filesIdCard[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          )),
                ),
                SizedBox(height: 16),
              },
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Stack(
                  children: [
                    CustomTextField(
                      controller: birthdayCtrl,
                      icon: Assets.icons.calender.image(height: 24, width: 24),
                      colorBorder: true,
                      enabled: false,
                      hintText: '생일을 선택해주세요',
                      label: '생년월일',
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: phoneCtrl,
                icon: Assets.icons.call.image(height: 24, width: 24),
                colorBorder: true,
                hintText: '핸드폰 번호를 입력해주세요.',
                label: '핸드폰',
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkBox = !checkBox;
                  });
                },
                child: Container(
                  color: AppColors.transparent,
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: AppColors.white,
                          focusColor: AppColors.BG,
                          activeColor: AppColors.BG,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          value: checkBox,
                          onChanged: (value) {
                            setState(() {
                              checkBox = value!;
                            });
                          }),
                      RichText(
                          textScaleFactor: 0.9,
                          text: TextSpan(
                              text: '업무에 도움이 되는 정확한 정보를 제공할 것을 서약합니다.',
                              style: rbtMedium(
                                  color: AppColors.black, fontSize: 14),
                              children: []))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  _login();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    '다음',
                    style: rbtMedium(color: AppColors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    Navigator.of(context).pushNamed(Pages.HOME);
    getContext()?.read<ProfileBloc>().add(ProfileApp(
        phoneNumber: phoneCtrl.text,
        birthday: birthdayCtrl.text,
        name: nameCtrl.text,
        avatar: filesAvatar,
        idCard: filesIdCard));
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }

  void _listenFetchData(BuildContext context, ProfileState state) {
    if (state.profileStatus == ProfileStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.profileStatus == ProfileStatus.failure) {
      _dismissLoading();
      AppAlert.showError(
          fToast,
          state.error != null
              ? state.error!.message != null
                  ? state.error!.message!
                  : 'Error!'
              : 'Error!');
      return;
    }
    if (state.profileStatus == ProfileStatus.success) {
      _dismissLoading();
      Navigator.of(context).pushNamed(Pages.HOME);
    }
  }

  _addImagesIdCard() async {
    SelectImgPickerDialog.show(context, chooseImgTap: () {
      _onPickPhotoIdCard(ImageSource.gallery);
    }, openCameraTap: () {
      _onPickPhotoIdCard(ImageSource.camera);
    });
  }

  _addImages() async {
    SelectImgPickerDialog.show(context, chooseImgTap: () {
      _onPickPhoto(ImageSource.gallery);
    }, openCameraTap: () {
      _onPickPhoto(ImageSource.camera);
    });
  }

  void _onPickPhotoIdCard(ImageSource source) async {
    try {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          filesIdCard.add(File(pickedFile.path));
        });
      }
    } catch (e) {}
  }

  void _onPickPhoto(ImageSource source) async {
    try {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          filesAvatar.add(File(pickedFile.path));
        });
      }
    } catch (e) {}
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.macOS:
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    DateFormat format = DateFormat("yyyy-dd-MM");
    String result = '';
    DatePicker.showDatePicker(
      context,
      onConfirm: (time) {
        result = format.format(time);
        setState(() {});
        birthdayCtrl.text = result;
      },
      locale: LocaleType.ko,
      theme: DatePickerTheme(
          containerHeight: MediaQuery.of(context).copyWith().size.height / 3,
          cancelStyle: rbtMedium(color: AppColors.colorText, fontSize: 14),
          doneStyle: rbtMedium(color: AppColors.colorText, fontSize: 14),
          itemStyle: rbtMedium(color: AppColors.colorText, fontSize: 14)),
    );
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    DateFormat format = DateFormat("yyyy-dd-MM");
    String result = '';
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                result = format.format(picked);
                setState(() {});
                birthdayCtrl.text = result;
              },
              // initialDateTime: selectedDate,
              minimumYear: 1972,
              maximumYear: 2045,
            ),
          );
        });
  }
}
