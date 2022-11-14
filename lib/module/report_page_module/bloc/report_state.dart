part of 'report_bloc.dart';

enum ReportStatus {  initial, loading, success, failure }

@immutable
class ReportState extends BaseBlocState {
  ReportState({
    this.reportStatus = ReportStatus.loading,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final ReportStatus reportStatus;

  ReportState copyWith({ReportStatus? reportStatus, ResponseError? error}) {
    return ReportState(
        reportStatus: reportStatus ?? this.reportStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [reportStatus];
}
