part of 'holiday_bloc.dart';

enum HolidayStatus {  initial, loading, success, failure }

@immutable
class HolidayState extends BaseBlocState {
  HolidayState({
    this.reportStatus = HolidayStatus.initial,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final HolidayStatus reportStatus;

  HolidayState copyWith({HolidayStatus? reportStatus, ResponseError? error}) {
    return HolidayState(
        reportStatus: reportStatus ?? this.reportStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [reportStatus];
}
