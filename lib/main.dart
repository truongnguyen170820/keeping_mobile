import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:keeping_time_mobile/common/global_key/global_key.dart';
import 'package:keeping_time_mobile/routes/app_router.dart';
import 'package:keeping_time_mobile/routes/pages.dart';
import 'package:keeping_time_mobile/theme/app_theme.dart';
import 'package:keeping_time_mobile/translations/app_translations.dart';
import 'package:keeping_time_mobile/utils/common.dart';

import 'business_logic/bloc/app_settings/bloc/app_settings_bloc.dart';
import 'business_logic/bloc/authentication/bloc/authentication_bloc.dart';
import 'common/easy_loading.dart';
import 'data/provider/account_provider/account_provider.dart';
import 'data/provider/account_provider/api_account_provider.dart';
import 'data/provider/campain_provider/api_campain_provider.dart';
import 'data/provider/campain_provider/campain_provider.dart';
import 'data/provider/local_store/local_store.dart';
import 'data/provider/local_store/shared_preferences_local_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp(
    campaignProvider: ApiCampaignProvider(),
    accountProvider: ApiAccountProvider(),
    localStore: SharedPreferencesLocalStore(),
  ));
  EasyLoadingCustom.initConfigLoading();
}

class MyApp extends StatefulWidget with GlobalKeyWidgetMixin {
  final AppRouter _router;

  MyApp(
      {Key? key,
      required this.accountProvider,
      required this.campaignProvider,
      required this.localStore})
      : _router = AppRouter();

  final LocalStore localStore;
  final AccountProvider accountProvider;
  final CampaignProvider campaignProvider;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with GlobalKeyStateMixin {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStore>(create: (context) => widget.localStore),
        RepositoryProvider<CampaignProvider>(
            create: (context) => widget.campaignProvider),
        RepositoryProvider<AccountProvider>(
            create: (context) => widget.accountProvider),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(localStore: context.read<LocalStore>())
                  ..add(CheckSaveAccountLogged()),
          ),
          BlocProvider<AppSettingsBloc>(
              create: (context) => AppSettingsBloc(
                  accountProvider: context.read<AccountProvider>(),
                  campaignProvider: context.read<CampaignProvider>())
              // ..add(AppInitial())
              ),
          // BlocProvider<PushNotificationServiceBloc>(
          //   create: (context) => PushNotificationServiceBloc(
          //     localStore: context.read<LocalStore>(),
          //   ),
          // ),
        ],
        child: GestureDetector(
          // Dismiss keyboard when clicked outside
          onTap: () => Common.dismissKeyboard(),
          child: ScreenUtilInit(
            designSize: Size(357, 636),
            builder: (ctx, e) => GetMaterialApp(
              navigatorKey: _navigatorKey,
              initialRoute: Pages.INITIAL,
              theme: AppThemes.themData,
              // getPages: AppPages.pages,
              onGenerateRoute: widget._router.getRoute,
              navigatorObservers: [widget._router.routeObserver],
              locale: AppTranslation.locale,
              localizationsDelegates: [],
              translationsKeys: AppTranslation.translations,
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(builder: (context, child) {
                return AppView(widget: child ?? const SizedBox.shrink());
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

class AppView extends StatefulWidget with GlobalKeyWidgetMixin {
  AppView({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with GlobalKeyStateMixin {
  late AppSettingsBloc _appSettingsBloc;

  @override
  void initState() {
    _registerEventBus();
    _appSettingsBloc = context.read<AppSettingsBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _unregisterEventBus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // newVersion.showAlertIfNecessary(context: context);
    return MultiBlocListener(
      listeners: [
        // BlocListener<AuthenticationBloc, AuthenticationState>(
        //   listenWhen: (previous, current) =>
        //       previous.status != current.status,
        //   listener: (context, state) {
        //     switch (state.status) {
        //       case AuthenticationStatus.authenticated:
        //         _navigator?.pushNamedAndRemoveUntil(
        //           Pages.HOME,
        //           (route) => false,
        //         );
        //         break;
        //       case AuthenticationStatus.unauthenticated:
        //         _navigator?.pushNamedAndRemoveUntil(
        //           Pages.LOGIN,
        //           (route) => false,
        //         );
        //         break;
        //       default:
        //         break;
        //     }
        //   },
        // ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) =>
              previous.logoutStatus != current.logoutStatus,
          listener: (context, state) {
            if (state.logoutStatus == LogoutStatus.loading) {
              EasyLoading.show();
              return;
            }

            if (state.logoutStatus == LogoutStatus.finish) {
              EasyLoading.dismiss();
              return;
            }
          },
        ),
      ],
      child: widget.widget,
    );
  }

  Future<void> _registerEventBus() async {
    // RxBus.register<UnauthenticatedEvent>(tag: Constants.unauthenticatedEvent)
    //     .listen((event) {
    //   // clear saved local data and return to auth screen
    //   context.read<AuthenticationBloc>().add(AuthenticationLogout(context));
    //   RxBus.post(GotoLogInPageEvent(), tag: Constants.gotoLogInPageEvent);
    // });
  }

  void _unregisterEventBus() {
    // RxBus.destroy();
  }
}
