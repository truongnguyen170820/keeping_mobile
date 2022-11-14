part of 'company_bloc.dart';

enum CompanyStatus { initial, loading, success, failure }

@immutable
class CompanyState extends BaseBlocState {
  const CompanyState({
    this.companyStatus = CompanyStatus.initial,
    ResponseError? error = const ResponseError(),
  }) : super(error: error);

  final CompanyStatus companyStatus;

  CompanyState copyWith({CompanyStatus? companyStatus, ResponseError? error}) {
    return CompanyState(
        companyStatus: companyStatus ?? this.companyStatus,
        error: error ?? this.error);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [companyStatus];
}
