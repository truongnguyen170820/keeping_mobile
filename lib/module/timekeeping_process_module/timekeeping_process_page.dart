import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/data/provider/campain_provider/campain_provider.dart';
import 'package:keeping_time_mobile/module/timekeeping_process_module/bloc/timekeeping_process_bloc.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';
import 'package:keeping_time_mobile/utils/dialog_widget.dart';
import 'package:keeping_time_mobile/utils/format_date.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/easy_loading.dart';

class TimekeepingProcessPage extends StatefulWidget with GlobalKeyWidgetMixin {
  TimekeepingProcessPage({Key? key}) : super(key: key);

  @override
  State<TimekeepingProcessPage> createState() => _TimekeepingProcessPageState();
}

class _TimekeepingProcessPageState extends State<TimekeepingProcessPage>
    with GlobalKeyStateMixin, SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;
  int tabPreviousIndex = 0;
  DateTime dateTimeNow = DateTime.now();
  DateTime? firstDay;
  DateTime? lastDay;
  DateTime? firstMonth;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(_onTabChange);
    int daysOfWeek = dateTimeNow.weekday - 1;
    firstDay = DateTime(
        dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - daysOfWeek);
    lastDay = firstDay?.add(const Duration(days: 6, hours: 23, minutes: 59));
    firstMonth = dateTimeNow.subtract(Duration(days: dateTimeNow.day - 1));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _onTabChange() {
    setState(() {
      tabIndex = _tabController.index;
      if (tabIndex != tabPreviousIndex) {}
      tabPreviousIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeKeepingProcessBloc>(
        create: (context) => TimeKeepingProcessBloc(
              campaignProvider: context.read<CampaignProvider>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<TimeKeepingProcessBloc, TimeKeepingProcessState>(
              listenWhen: (previous, current) =>
                  previous.processStatus != current.processStatus,
              listener: _listenFetchData,
            ),
          ],
          child: _buildContent(context),
        ));
  }

  Scaffold _buildContent(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.whiteDark2,
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title:
            Text('출퇴근관리', style: rbtBold(color: AppColors.black, fontSize: 20)),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.BG,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Center(
              child: TabBar(
                onTap: (value) {
                  _onTabChange();
                },
                isScrollable: true,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                controller: _tabController,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4 - 25),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  color: AppColors.white,
                ),
                labelColor: AppColors.BG,
                unselectedLabelColor: AppColors.white,
                labelStyle: rbtBold(color: AppColors.BG, fontSize: 16),
                tabs: [
                  Tab(
                    text: '주별',
                  ),
                  Tab(
                    text: '월별',
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              child: TabBarView(controller: _tabController, children: [
            _buildDayOfWeek(),
            _buildDayOfWeek(),
          ])),
        ],
      ),
    );
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }

  void _listenFetchData(BuildContext context, TimeKeepingProcessState state) {
    if (state.processStatus == ProcessStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.processStatus == ProcessStatus.failure) {
      _dismissLoading();
      return;
    }
    if (state.processStatus == ProcessStatus.success) {
      _dismissLoading();
    }
  }

  List tableList = ['날짜', '출근', '퇴근', '총 작업 시간', '작업 상태'];

  _buildTimeWork() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.whiteDark))),
        child: Column(
          children: [
            if (_tabController.index == 0) ...{
              Wrap(
                spacing: 10,
                children: List.generate(3, (index) => _buildItemTime()),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text("기본 작업 시간",
                        style: rbtBold(color: AppColors.black, fontSize: 14)),
                    Spacer(),
                    Text("40시간",
                        style: rbtMedium(
                            color: AppColors.colorText, fontSize: 14)),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 16,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const LinearProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.green),
                        backgroundColor: AppColors.colorIndicator,
                        color: AppColors.green,
                        value: 960 / 2400,
                      ),
                    ),
                  ),
                  Align(
                      child: Text("16 시간",
                          style:
                              rbtMedium(color: AppColors.white, fontSize: 12),
                          textAlign: TextAlign.center),
                      alignment: AlignmentGeometry.lerp(
                          const Alignment(-1.1, -1),
                          const Alignment(0.3, -1),
                          (960 / 2400)) as AlignmentGeometry),
                ],
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text("연장시간",
                        style: rbtBold(color: AppColors.black, fontSize: 14)),
                    Spacer(),
                    Text("12시간",
                        style: rbtMedium(
                            color: AppColors.colorIndicatorOften,
                            fontSize: 14)),
                    SizedBox(width: 40)
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 16,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.colorLightO),
                        backgroundColor: AppColors.colorIndicator,
                        color: AppColors.colorLightO,
                        value: 960 / 2400,
                      ),
                    ),
                  ),
                  Align(
                      child: Text("16 시간",
                          style:
                              rbtMedium(color: AppColors.white, fontSize: 12),
                          textAlign: TextAlign.center),
                      alignment: AlignmentGeometry.lerp(
                          const Alignment(-1.1, -1),
                          const Alignment(0.3, -1),
                          (960 / 2400)) as AlignmentGeometry),
                ],
              ),
              SizedBox(height: 24),
            },

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.whiteDark),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15,),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWorkDay('늦은', '0'),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    color: AppColors.whiteDark,
                    width: 1,
                    height: 40,
                  ),
                  _buildWorkDay('결석', '0'),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    color: AppColors.whiteDark,
                    width: 1,
                    height: 40,
                  ),
                  _buildWorkDay('사용한 휴가', '3'),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    color: AppColors.whiteDark,
                    width: 1,
                    height: 40,
                  ),
                  _buildWorkDay('남은연차', '4')
                ],
              ),
            ),
            if (_tabController.index == 1) ...{
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: AppColors.whiteDark))),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("총 근무일:",
                                style: rbtMedium(
                                    color: AppColors.black, fontSize: 12)),
                            SizedBox(width: 25),
                            Text("20일",
                                style: rbtBold(
                                    color: AppColors.black, fontSize: 12))
                          ],
                        ),
                        Row(
                          children: [
                            Text("총 작업 시간:",
                                style: rbtMedium(
                                    color: AppColors.black, fontSize: 12)),
                            SizedBox(width: 10),
                            Text("103시간 20분",
                                style: rbtBold(
                                    color: AppColors.black, fontSize: 12))
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        AppAlertDialog.show(context,
                            title: 'helolo', message: "clcik");
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(100)),
                        child: Text('급여 보기',
                            style:
                                rbtBold(color: AppColors.white, fontSize: 14)),
                      ),
                    )
                  ],
                ),
              )
            },
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.colorGrey)),
              ),
              child: Wrap(
                children: List.generate(
                    tableList.length - 1,
                    (index) => Container(
                        width: MediaQuery.of(context).size.width / 4 - 10,
                        child: Center(child: Text("${tableList[index]}")))),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                children: List.generate(
                    10,
                    (index) => Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: AppColors.colorGrey))),
                        child: Wrap(
                          children: List.generate(
                              tableList.length - 1,
                              (indexTable) => _buildItemTimeList("con cac",
                                  index: indexTable)),
                        ))),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  _buildItemTimeList(String? item, {int? index}) {
    Color color = AppColors.colorBlackText;
    TextStyle textStyle = rbtRegularNormal(color: color, fontSize: 14);
    switch (index) {
      case 0:
        textStyle = textStyle;
        break;
      case 1:
        textStyle = textStyle;
        break;
      case 2:
        break;
      case 3:
        textStyle = rbtBold(color: AppColors.colorText, fontSize: 14);
        break;
    }

    return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width / 4 - 10,
        child: Center(
            child: _tabController.index == 1
                ? Column(
                    children: [
                      Text("31일 일요일"),
                    ],
                  )
                : Text("31일 일요일", style: textStyle)));
  }

  _buildItemTime() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(6),
          color: AppColors.border.withOpacity(0.6)),
      child: Column(
        children: [
          Text('총 작업 시간',
              style: rbtMedium(color: AppColors.colorText, fontSize: 12)),
          SizedBox(height: 4),
          Text('38시간 20분',
              style: rbtBold(color: AppColors.colorText, fontSize: 16)),
        ],
      ),
    );
  }

  _buildWorkDay(String? name, String? date) {
    return Column(
      children: [
        Text(name ?? '',
            style: rbtMedium(color: AppColors.black, fontSize: 16)),
        Text(date ?? '',
            style: rbtMedium(color: AppColors.black, fontSize: 14)),
      ],
    );
  }

  void _openDatePicker(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        // locale: Locale("KR"),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
        cancelText: 'huỷ',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColors.BG,
              accentColor: AppColors.BG,
              colorScheme: const ColorScheme.light(primary: AppColors.BG),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child ?? SizedBox(),
          );
        },
        confirmText: "ok",
        helpText: "ok");

    if (datePicked != null) {
      print(datePicked);
    }
  }

  _buildDayOfWeek() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _tabController.index == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            firstMonth = DateTime.parse(Jiffy(firstMonth)
                                .startOf(Units.MONTH)
                                .subtract(months: 1)
                                .format('yyyy-MM-dd'));
                          });
                          print(firstMonth);
                        },
                        child: const Icon(Icons.arrow_back_ios_new_outlined,
                            color: AppColors.colorText)),
                    const SizedBox(width: 16),
                    Text("${firstMonth?.year}년 ${firstMonth?.month}월 ",
                        style: rbtBold(color: AppColors.black, fontSize: 14)),
                    const SizedBox(width: 16),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            firstMonth = DateTime.parse(Jiffy(firstMonth)
                                .startOf(Units.MONTH)
                                .add(months: 1)
                                .format('yyyy-MM-dd'));
                          });
                          print(firstMonth);
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded,
                            color: AppColors.colorText)),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            firstDay = firstDay?.subtract(
                                Duration(days: firstDay!.weekday + 6));
                            lastDay = lastDay
                                ?.subtract(Duration(days: lastDay!.weekday));
                          });
                        },
                        child: const Icon(Icons.arrow_back_ios_new_outlined,
                            color: AppColors.colorText)),
                    const SizedBox(width: 16),
                    Text(
                        "${firstDay?.year}년 ${firstDay?.month}월 ${firstDay?.day}일 - ",
                        style: rbtBold(color: AppColors.black, fontSize: 14)),
                    Text(
                        "${lastDay?.year}년 ${lastDay?.month}월 ${lastDay?.day}일",
                        style: rbtBold(color: AppColors.black, fontSize: 14)),
                    const SizedBox(width: 16),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            firstDay = firstDay
                                ?.add(Duration(days: firstDay!.weekday + 6));
                            lastDay =
                                lastDay?.add(Duration(days: lastDay!.weekday));
                          });
                        },
                        child: const Icon(Icons.arrow_forward_ios_rounded,
                            color: AppColors.colorText)),
                  ],
                ),
          SizedBox(height: 10),
          _buildTimeWork()
        ],
      ),
    );
  }
}
