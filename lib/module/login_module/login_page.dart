import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/gen/assets.gen.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field.dart';

import '../../business_logic/bloc/authentication/bloc/authentication_bloc.dart';
import '../../common/easy_loading.dart';
import '../../data/provider/account_provider/account_provider.dart';
import '../../data/provider/local_store/local_store.dart';
import '../../routes/app_router.dart';
import '../../routes/pages.dart';
import '../../utils/app_alert.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with GlobalKeyStateMixin {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
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
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
              accountProvider: context.read<AccountProvider>(),
              localStore: context.read<LocalStore>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<LoginBloc, LoginState>(
              listenWhen: (previous, current) =>
                  previous.loginStatus != current.loginStatus,
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
        leading: const SizedBox(),
        backgroundColor: AppColors.white,
        elevation: 0,
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
                              text: '자동 로그인',
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
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Pages.REGISTER);
                },
                child: RichText(
                    text: TextSpan(
                        text: '회원가입을 하시겠습니까?',
                        style: rbtMedium(color: AppColors.black, fontSize: 14),
                        children: [
                      TextSpan(
                          text: '회원가입',
                          style: rbtMedium(
                              color: AppColors.colorText, fontSize: 14)),
                    ])),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    Navigator.of(context).pushNamed(Pages.HOME);
    getContext()
        ?.read<LoginBloc>()
        .add(LoginApp(email: emailCtrl.text, password: passwordCtrl.text));
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }

  void _listenFetchData(BuildContext context, LoginState state) {
    if (state.loginStatus == LoginStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.loginStatus == LoginStatus.failure) {
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
    if (state.loginStatus == LoginStatus.success) {
      _dismissLoading();
      saveAutoLoginStatus();
      context.read<AuthenticationBloc>().add(
        AuthenticationStatusChanged(AuthenticationStatus.authenticated),
      );
      Navigator.of(context).pushNamed(Pages.HOME);
    }
  }

  saveAutoLoginStatus() {
    getContext()
        ?.read<LoginBloc>()
        .add(SaveAutoLoginStatusEvent(status: checkBox));
  }
}
