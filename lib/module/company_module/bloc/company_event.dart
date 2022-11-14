part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent extends Equatable {}

class CompanyApp extends CompanyEvent {
  CompanyApp(
      {this.countryName,
      this.nameCompany,
      this.nameAddressCompany,
      this.workingPosition});

  final String? countryName;
  final String? nameCompany;
  final String? nameAddressCompany;
  final String? workingPosition;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [workingPosition, nameAddressCompany, nameCompany, countryName];
}
