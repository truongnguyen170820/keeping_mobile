import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field_my.dart';

import '../../common/easy_loading.dart';
import '../../data/provider/campain_provider/campain_provider.dart';
import '../../gen/assets.gen.dart';
import '../../utils/app_alert.dart';
import 'bloc/holiday_bloc.dart';

class HolidayPage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => HolidayPage());
  }

  HolidayPage({Key? key}) : super(key: key);

  @override
  State<HolidayPage> createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> with GlobalKeyStateMixin {
  List status = [
    '교대를 바꾸다',
    '지각 일찍 출발',
    '그만두다',
    '스위치 시프트',
    '급여 불만',
    '제안된 초과 근무',
  ];
  List paid = ['유급휴일', '무급휴일'];

  TextEditingController topicCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HolidayBloc>(
        create: (context) => HolidayBloc(
              campaignProvider: context.read<CampaignProvider>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<HolidayBloc, HolidayState>(
              listenWhen: (previous, current) =>
                  previous.reportStatus != current.reportStatus,
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
        centerTitle: true,
        title: Text("보고서 생성",
            style: rbtBold(color: AppColors.black, fontSize: 20)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldMy(
                controller: topicCtrl,
                label: '제목',
                borderRadius: 5,
                hintText: '',
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                    status.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              topicCtrl.text = status[index];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: topicCtrl.text == status[index]
                                    ? AppColors.green
                                    : AppColors.bgApp),
                            child: Text(status[index],
                                style: rbtBold(
                                    color: topicCtrl.text == status[index]
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontSize: 14)),
                          ),
                        )),
              ),
              SizedBox(height: 16),
              CustomTextFieldMy(
                label: '메모',
                borderRadius: 5,
                maxLines: 15,
                hintText: '입력하시기 바랍니다.',
                controller: contentCtrl,
              ),
              GestureDetector(
                onTap: () {
                  _register();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.green,
                  ),
                  child: Text('보내다',
                      textAlign: TextAlign.center,
                      style: rbtMedium(color: AppColors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _register() {
    getContext()
        ?.read<HolidayBloc>()
        .add(Report(content: contentCtrl.text, topic: topicCtrl.text));
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }

  void _listenFetchData(BuildContext context, HolidayState state) {
    if (state.reportStatus == HolidayStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.reportStatus == HolidayStatus.failure) {
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
    if (state.reportStatus == HolidayStatus.success) {
      Navigator.of(context).pop();
      _dismissLoading();
    }
  }
}
