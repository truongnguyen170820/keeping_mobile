part of 'holiday_bloc.dart';

@immutable
abstract class HolidayEvent extends Equatable {}

class Report extends HolidayEvent {
  Report({this.topic, this.content});

  final String? topic;
  final String? content;

  @override
  // TODO: implement props
  List<Object?> get props => [topic, content];
}
