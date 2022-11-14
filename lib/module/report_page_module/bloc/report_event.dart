part of 'report_bloc.dart';

@immutable
abstract class ReportEvent extends Equatable {}

class Report extends ReportEvent {
  Report({this.topic, this.content});

  final String? topic;
  final String? content;

  @override
  // TODO: implement props
  List<Object?> get props => [topic, content];
}