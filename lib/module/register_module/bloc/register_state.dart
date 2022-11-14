part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

@immutable
class RegisterState extends BaseBlocState {
  const RegisterState({
    this.registerStatus = RegisterStatus.initial,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final RegisterStatus registerStatus;

  RegisterState copyWith(
      {RegisterStatus? registerStatus, ResponseError? error}) {
    return RegisterState(
        registerStatus: registerStatus ?? this.registerStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [registerStatus];
}
