// part of 'push_notification_service_bloc.dart';
//
// @immutable
// class PushNotificationServiceState extends BaseBlocState {
//   PushNotificationServiceState({
//     this.remoteMessage,
//     this.isForeground = false,
//     ResponseError? error = const ResponseError(),
//   }) : super(error: error);
//
//   RemoteMessage? remoteMessage;
//   final bool isForeground;
//
//   PushNotificationServiceState copyWith({
//     RemoteMessage? remoteMessage,
//     bool? isForeground,
//     ResponseError? error,
//   }) {
//     return PushNotificationServiceState(
//       remoteMessage: remoteMessage ?? this.remoteMessage,
//       isForeground: isForeground ?? this.isForeground,
//       error: error ?? this.error,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     remoteMessage,
//     isForeground,
//   ];
// }
