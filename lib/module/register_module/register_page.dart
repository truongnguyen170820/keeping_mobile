import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field.dart';

import '../../common/easy_loading.dart';
import '../../data/provider/account_provider/account_provider.dart';
import '../../routes/pages.dart';
import '../../utils/app_alert.dart';
import 'bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => RegisterPage());
  }

  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with GlobalKeyStateMixin {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController enterPasswordCtrl = TextEditingController();
  bool checkBox = false;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(
              accountProvider: context.read<AccountProvider>(),
              // localStore: context.read<LocalStore>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<RegisterBloc, RegisterState>(
              listenWhen: (previous, current) =>
                  previous.registerStatus != current.registerStatus,
              listener: _listenFetchData,
            ),
          ],
          child: _buildContent(context),
        ));
  }

  Scaffold _buildContent(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Assets.icons.back.image(width: 32, height: 32),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Assets.images.logo.image(width: 103, height: 130),
              SizedBox(height: 32),
              Text('회원가입 하기',
                  style: rbtBold(color: AppColors.black, fontSize: 24)),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                controller: emailCtrl,
                hintText: '아이디를 입력해주세요',
                colorBorder: true,
                icon: Assets.icons.message.image(height: 24, width: 24),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                controller: passwordCtrl,
                hintText: '버번을 입력바랍니다',
                colorBorder: true,
                icon: Assets.icons.bag.image(height: 24, width: 24),
              ),
              SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                controller: enterPasswordCtrl,
                hintText: '버번을 입력바랍니다',
                colorBorder: true,
                icon: Assets.icons.bag.image(height: 24, width: 24),
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
                              text: '저는 ',
                              style: rbtMedium(
                                  color: AppColors.black, fontSize: 14),
                              children: [
                                TextSpan(
                                    text: '사용자 계약 및 개인 정보 보호 정책을',
                                    style: rbtMedium(
                                        color: AppColors.colorText,
                                        fontSize: 14)),
                                TextSpan(
                                    text: ' 읽고 동의합니다',
                                    style: rbtMedium(
                                        color: AppColors.black, fontSize: 14))
                              ]))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  if(!!checkBox){
                    _register();
                  }else{
                    AppAlert.showError(
                        fToast, '');
                  }

                  // Navigator.of(context).pushNamed(Pages.COMPANY);
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
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: RichText(
                    text: TextSpan(
                        text: '이미 아이디가 있습니까? ',
                        style: rbtMedium(color: AppColors.black, fontSize: 14),
                        children: [
                      TextSpan(
                          text: '로그인화면',
                          style: rbtMedium(
                              color: AppColors.colorText, fontSize: 14)),
                      TextSpan(
                          text: ' 이동',
                          style:
                              rbtMedium(color: AppColors.black, fontSize: 14))
                    ])),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }
  void _listenFetchData(BuildContext context, RegisterState state) {
    if (state.registerStatus == RegisterStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.registerStatus == RegisterStatus.failure) {
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
    if (state.registerStatus == RegisterStatus.success) {
      _dismissLoading();
      Navigator.of(context).pushNamed(Pages.COMPANY);
    }
  }

  _register() {
    Navigator.of(context).pushNamed(Pages.COMPANY);
    getContext()?.read<RegisterBloc>().add(RegisterApp(
        email: emailCtrl.text,
        password: passwordCtrl.text,
        confirmPassword: enterPasswordCtrl.text));
  }
}
