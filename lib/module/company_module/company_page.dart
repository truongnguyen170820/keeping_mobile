import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/module/company_module/bloc/company_bloc.dart';
import 'package:keeping_time_mobile/theme/app_colors.dart';
import 'package:keeping_time_mobile/theme/style.dart';

import '../../common/constants.dart';
import '../../common/easy_loading.dart';
import '../../data/provider/account_provider/account_provider.dart';
import '../../gen/assets.gen.dart';
import '../../routes/pages.dart';
import '../../utils/app_alert.dart';
import '../../utils/widget/custom_text_field.dart';

class CompanyPage extends StatefulWidget with GlobalKeyWidgetMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => CompanyPage());
  }

  CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> with GlobalKeyStateMixin {
  String? countryName;
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('82');
  TextEditingController nameCompanyCtrl = TextEditingController();
  TextEditingController addressCompanyCtrl = TextEditingController();
  final dropdownState = GlobalKey<FormFieldState>();
  String allMedia = "Manage";
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
    return BlocProvider<CompanyBloc>(
        create: (context) => CompanyBloc(
              accountProvider: context.read<AccountProvider>(),
            ),
        child: MultiBlocListener(
          listeners: [
            BlocListener<CompanyBloc, CompanyState>(
              listenWhen: (previous, current) =>
                  previous.companyStatus != current.companyStatus,
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
        title: Text('회사', style: rbtBold(color: AppColors.black, fontSize: 18)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              '작업 프로세스를 추적할 수 있도록 정보를 제공해주세요',
              style: rbtMedium(color: AppColors.black, fontSize: 14),
            ),
            SizedBox(height: 24),
            Text(
              '국가',
              style: rbtMedium(color: AppColors.black, fontSize: 18),
            ),
            GestureDetector(
              onTap: () {
                _openCountryPickerDialog();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.black),
                ),
                child: Row(
                  children: [
                    CountryPickerUtils.getDefaultFlagImage(
                        _selectedDialogCountry),
                    const SizedBox(width: 10),
                    Text(_selectedDialogCountry.name,
                        style: rbtMedium(
                            color: AppColors.colorBlackText, fontSize: 14)),
                    Spacer(),
                    const Icon(Icons.arrow_drop_down_rounded)
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: '회사이름',
              labelColor: '*',
              controller: nameCompanyCtrl,
              hintText: '회사를 입력해주세요',
              colorBorder: true,
              icon: Assets.icons.search.image(height: 24, width: 24),
            ),
            SizedBox(height: 16),
            CustomTextField(
              label: '회사주소',
              controller: addressCompanyCtrl,
              hintText: '회사 주소를 설정해주세요',
              colorBorder: true,
              icon: Assets.icons.location.image(height: 24, width: 24),
            ),
            SizedBox(height: 16),
            Text('부서', style: rbtMedium(color: AppColors.black, fontSize: 18)),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Assets.icons.jobPosition.image(height: 24, width: 24),
                  SizedBox(width: 16),
                  _buildDropDown(context)
                ],
              ),
            ),
            SizedBox(height: 24),
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
                        text: TextSpan(
                            text: '제 작업 과정을 기록하여 이 회사에 보내드립니다.',
                            style:
                                rbtMedium(color: AppColors.black, fontSize: 14),
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
                padding: const EdgeInsets.symmetric(vertical: 13),
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
          ],
        ),
      ),
    );
  }

  _login() {
    Navigator.of(context).pushNamed(Pages.PROFILE);
    getContext()?.read<CompanyBloc>().add(CompanyApp(
        countryName: countryName,
        nameAddressCompany: addressCompanyCtrl.text,
        nameCompany: nameCompanyCtrl.text,
        workingPosition: allMedia));
  }

  _dismissLoading() {
    EasyLoadingCustom.initConfigLoading();
    EasyLoading.dismiss();
  }

  void _listenFetchData(BuildContext context, CompanyState state) {
    if (state.companyStatus == CompanyStatus.loading) {
      EasyLoadingCustom.initConfigLoadingData();
      EasyLoading.show();
      return;
    }
    if (state.companyStatus == CompanyStatus.failure) {
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
    if (state.companyStatus == CompanyStatus.success) {
      _dismissLoading();
      Navigator.of(context).pushNamed(Pages.PROFILE);
    }
  }

  Widget _buildDropDown(BuildContext context) {
    dynamic medias = DATA_PERSONNEL.map((item) => item['name']).toList();
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
            Icons.arrow_drop_down_rounded,
            color: AppColors.black,
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

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            onValuePicked: (Country country) => setState(() {
              _selectedDialogCountry = country;
              countryName = country.name;
            }),
            itemBuilder: _buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],
          ),
        ),
      );

  Widget _buildDialogItem(Country country) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(width: 8.0),
            const SizedBox(width: 8.0),
            Flexible(child: Text(country.name)),
          ],
        ),
      );
}
