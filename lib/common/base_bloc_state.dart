import 'package:equatable/equatable.dart';

import 'response_error.dart';

abstract class BaseBlocState extends Equatable {
  final ResponseError? error;

  const BaseBlocState({this.error});
}
