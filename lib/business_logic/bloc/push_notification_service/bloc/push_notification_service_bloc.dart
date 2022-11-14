// import 'dart:async';
// import 'dart:io';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../common/constants.dart';
// import '../../../../common/events/rx_events.dart';
//
// part 'push_notification_service_event.dart';
//
// part 'push_notification_service_state.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // dynamic body = jsonDecode(message.data['body']);
//   print('message remote ${message.notification?.body}');
//   print('message remote ${message.notification?.title}');
// }
//
// class PushNotificationServiceBloc
//     extends Bloc<PushNotificationServiceEvent, PushNotificationServiceState> {
//   PushNotificationServiceBloc() : super(PushNotificationServiceState());
//
//   // add default_notification_channel_id in AndroidManifest
//   final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       description: 'This channel is used for important notifications.',
//       // description
//       importance: Importance.high,
//       sound: RawResourceAndroidNotificationSound('alarm'),
//       playSound: true);
//
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   AndroidNotificationChannel get channel => _channel;
//
//   FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
//       _flutterLocalNotificationsPlugin;
//
//   @override
//   Stream<PushNotificationServiceState> mapEventToState(
//     PushNotificationServiceEvent event,
//   ) async* {
//     if (event is PushNotificationSetup) {
//       yield* _mapPushNotificationSetupToState(event);
//     } else if (event is PushNotificationRegisterToken) {
//       yield* _mapPushNotificationRegisterTokenToState(event);
//     } else if (event is PushNotificationHandleRemoteMessage) {
//       yield state.copyWith(
//         remoteMessage: event.message,
//         isForeground: event.isForeground,
//       );
//     }
//   }
//
//   Stream<PushNotificationServiceState> _mapPushNotificationSetupToState(
//       PushNotificationSetup event) async* {
//     // UserModel? user = await _localStore.getLoggedAccount();
//     yield state.copyWith(
//       isForeground: false,
//     )..remoteMessage = null;
//     if (Platform.operatingSystem == 'android') {
//       _androidRegisterNotifications();
//     } else if (Platform.operatingSystem == 'ios') {}
//   }
//
//   Stream<PushNotificationServiceState> _mapPushNotificationRegisterTokenToState(
//       PushNotificationRegisterToken event) async* {
//     try {
//     } catch (e) {
//     }
//   }
//
//   // _requestIOSPermission() {
//   //   flutterLocalNotificationsPlugin
//   //       .resolvePlatformSpecificImplementation<
//   //       IOSFlutterLocalNotificationsPlugin>()!
//   //       .requestPermissions(
//   //     alert: false,
//   //     badge: true,
//   //     sound: true,
//   //   );
//   // }
//
//   // Android initial setup
//   Future<void> _androidRegisterNotifications() async {
//     await Firebase.initializeApp();
//
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_channel);
//
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//
//     );
//     dynamic user = CacheHelper.instance.idUser1;
//     FirebaseMessaging.instance.subscribeToTopic("ALL_DEVICE_DEV_$user");
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       if (state.remoteMessage != null) {
//         _androidOnMessage(state.remoteMessage!);
//       }
//     });
//
//     //onLaunch
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         _flutterLocalNotificationsPlugin.cancelAll();
//         _androidOnMessage(message);
//       }
//     });
//
//     //onMessage foreground
//     FirebaseMessaging.onMessage.listen(_androidOnMessageForeground);
//
//     //onResume
//     FirebaseMessaging.onMessageOpenedApp.listen(_androidOnMessage);
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // get token and send it to server
//     String? token = await FirebaseMessaging.instance.getToken();
//
//     if (token != null) {
//       add(PushNotificationRegisterToken(token: token));
//     }
//   }
//
//   // IOS initial setup
//   Future<void> _iOSRegisterNotifications() async {
//     await Firebase.initializeApp();
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       // badge: true,
//       sound: true,
//     );
//
//     dynamic userCache = CacheHelper.instance.idUser1;
//
//     if (userCache != null) {
//       FirebaseMessaging.instance.subscribeToTopic("ALL_DEVICE_DEV_$userCache");
//       FirebaseMessaging.instance
//           .subscribeToTopic("ALL_DEVICE_DEV_chat$userCache");
//       FirebaseMessaging.instance.requestPermission();
//     }
//     var initializationSettingsIOS = const IOSInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );
//     var initializationSettings =
//         InitializationSettings(iOS: initializationSettingsIOS);
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//
//       if (state.remoteMessage != null) {
//         _iosOnMessage(state.remoteMessage!);
//       }
//     });
//     //onLaunch
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         _iosOnMessage(message);
//       }
//     });
//
//     //onMessage foreground
//     FirebaseMessaging.onMessage.listen(_iosOnMessageForeground);
//
//     //onResume
//     FirebaseMessaging.onMessageOpenedApp.listen(_iosOnMessage);
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // get token and send it to server
//     String? token = await FirebaseMessaging.instance.getToken();
//
//     if (token != null) {
//       add(PushNotificationRegisterToken(token: token));
//     }
//   }
//
//   Future<void> _androidOnMessage(RemoteMessage message) async {
//     dynamic account = CacheHelper.instance.idUser1;
//     if (account == null) {
//       return;
//     }
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null) {
//       add(PushNotificationHandleRemoteMessage(
//           message: message, isForeground: false));
//     }
//   }
//
//   Future<void> _iosOnMessage(RemoteMessage message) async {
//     dynamic account = CacheHelper.instance.idUser1;
//     if (account == null) {
//       return;
//     }
//
//     RemoteNotification? notification = message.notification;
//     AppleNotification? ios = message.notification?.apple;
//     if (notification != null && ios != null) {
//       add(PushNotificationHandleRemoteMessage(
//           message: message, isForeground: false));
//     }
//   }
//
//   Future<void> _androidOnMessageForeground(RemoteMessage message) async {
//
//     dynamic account = CacheHelper.instance.idUser1;
//     if (account == null) {
//       return;
//     }
//     RxBus.post(RefreshChatNotifi(), tag: Constants.rxBusRefreshChat);
//     add(PushNotificationHandleRemoteMessage(
//         message: message, isForeground: true));
//   }
//
//   Future<void> _iosOnMessageForeground(RemoteMessage message) async {
//     dynamic account = CacheHelper.instance.idUser1;
//     if (account == null) {
//       return;
//     }
//
//     add(PushNotificationHandleRemoteMessage(
//         message: message, isForeground: true));
//   }
// }
