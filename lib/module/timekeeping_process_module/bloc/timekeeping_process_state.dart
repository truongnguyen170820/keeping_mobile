part of 'timekeeping_process_bloc.dart';

enum ProcessStatus { loading, success, failure }

@immutable
class TimeKeepingProcessState extends BaseBlocState {
  TimeKeepingProcessState({
    this.processStatus = ProcessStatus.loading,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final ProcessStatus processStatus;

  TimeKeepingProcessState copyWith(
      {ProcessStatus? processStatus, ResponseError? error}) {
    return TimeKeepingProcessState(
        processStatus: processStatus ?? this.processStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [processStatus];
}
