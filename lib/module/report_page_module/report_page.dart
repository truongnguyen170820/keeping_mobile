import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field.dart';
import 'package:keeping_time_mobile/utils/widget/custom_text_field_my.dart';

import '../../common/constants.dart';
import '../../common/easy_loading.dart';
import '../../data/provider/campain_provider/campain_provider.dart';
import '../../gen/assets.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/style.dart';
import '../../utils/app_alert.dart';
import 'bloc/report_bloc.dart';

class ReportPage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => ReportPage());
  }

  ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with GlobalKeyStateMixin {
  List paid = ['유급휴일', '무급휴일'];
  late FToast fToast;

  TextEditingController dateBeginCtrl = TextEditingController();
  TextEditingController daySuggestedCtrl = TextEditingController();
  TextEditingController dateEndCtrl = TextEditingController();
  final dropdownState = GlobalKey<FormFieldState>();
  String allMedia = "유급휴일";

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportBloc>(
        create: (context) => ReportBloc(
              campaignProvider: context.read<CampaignProvider>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ReportBloc, ReportState>(
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
        title: Text("제안된 휴일",
            style: rbtBold(color: AppColors.black, fontSize: 20)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text('휴가의 종류',
                style: rbtBold(color: AppColors.black, fontSize: 18)),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.colorIndicator, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _buildDropDown(context),
            ),
            const SizedBox(height: 16),
            CustomTextFieldMy(
              controller: daySuggestedCtrl,
              borderRadius: 8,
              label: '제안된 일 수',
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _selectDate(context, dateBeginCtrl);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: CustomTextFieldMy(
                      controller: dateBeginCtrl,
                      borderRadius: 8,
                      label: '종료일',
                      enabled: false,
                      customIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Assets.icons.calender
                            .image(width: 24, height: 24, color: AppColors.BG),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context, dateEndCtrl);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: CustomTextFieldMy(
                      borderRadius: 8,
                      controller: dateEndCtrl,
                      label: '종료일',
                      enabled: false,
                      customIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Assets.icons.calender
                            .image(width: 24, height: 24, color: AppColors.BG),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.BG,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('보내다',
                    textAlign: TextAlign.center,
                    style: rbtMedium(color: AppColors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown(BuildContext context) {
    dynamic medias = DATA_VACATION.map((item) => item['name']).toList();
    List<DropdownMenuItem<String>> items =
        medias.map<DropdownMenuItem<String>>((String? value) {
      return DropdownMenuItem<String>(
        // alignment: Alignment.center,
        value: value,
        child: Text(
          value ?? '',
          style: rbtMedium(color: AppColors.black, fontSize: 14),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      );
    }).toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: dropdownState,
          // alignment: Alignment.center,
          isExpanded: true,
          value: allMedia,
          hint: Text(allMedia,
              style: rbtMedium(
                  color: AppColors.black.withOpacity(0.3), fontSize: 14)),
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.colorIndicator,
            size: 24,
          ),
          items: items,
          onChanged: (String? value) {
            // this.selectedStation = value;
            setState(() {
              allMedia = value!;
            });
            // _filterMedia(value);
          },
        ),
      ),
    );
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context, controller);
      case TargetPlatform.iOS:
        return buildCupertinoDatePicker(context, controller);
      case TargetPlatform.macOS:
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(
      BuildContext context, TextEditingController controller) async {
    DateFormat format = DateFormat("yyyy-dd-MM");
    String result = '';
    DatePicker.showDatePicker(
      context,
      onConfirm: (time) {
        result = format.format(time);
        setState(() {});
        controller.text = result;
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
  buildCupertinoDatePicker(
      BuildContext context, TextEditingController controller) {
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
                controller.text = result;
              },
              // initialDateTime: selectedDate,
              minimumYear: 1972,
              maximumYear: 2045,
            ),
          );
        });
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }

  void _listenFetchData(BuildContext context, ReportState state) {
    if (state.reportStatus == ReportStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.reportStatus == ReportStatus.failure) {
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
    if (state.reportStatus == ReportStatus.success) {
      Navigator.of(context).pop();
      _dismissLoading();
    }
  }
}
