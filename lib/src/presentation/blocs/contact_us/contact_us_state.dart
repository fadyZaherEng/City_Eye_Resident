part of 'contact_us_bloc.dart';

abstract class ContactUsState extends Equatable {
  @override
  List<Object> get props => [
        identityHashCode(this),
      ];
}

class ContactUsInitial extends ContactUsState {}

class ShowLoadingState extends ContactUsState {}

class HideLoadingState extends ContactUsState {}

class SuccessContactUsSendState extends ContactUsState {
  final String status;

  SuccessContactUsSendState(this.status);

  @override
  List<Object> get props => [status];
}

class ErrorContactUsSendState extends ContactUsState {
  final String status;

  ErrorContactUsSendState(this.status);

  @override
  List<Object> get props => [status];
}

class SuccessFetchCountriesState extends ContactUsState {
  final List<Country> countries;

  SuccessFetchCountriesState({required this.countries});

  @override
  List<Object> get props => [countries];
}

class ErrorFetchCountriesState extends ContactUsState {
  final String message;

  ErrorFetchCountriesState({required this.message});

  @override
  List<Object> get props => [message];
}

class SetCountryState extends ContactUsState {
  final String countryName;
  final String countryCode;

  SetCountryState({
    required this.countryName,
    required this.countryCode,
  });

  @override
  List<Object> get props => [countryName, countryCode];
}

class OpenCountryBottomSheetState extends ContactUsState {}

class ContactUsValidationState extends ContactUsState {}

class NavigateBackState extends ContactUsState {}

class ValidateUsernameState extends ContactUsState {}

class ValidateUsernameEmptyFormatState extends ContactUsState {
  final String nameValidatorMessage;

  ValidateUsernameEmptyFormatState({
    required this.nameValidatorMessage,
  });

  @override
  List<Object> get props => [nameValidatorMessage];
}

class ValidateEmailState extends ContactUsState {}

class ValidateEmailEmptyFormatState extends ContactUsState {
  final String emailValidatorMessage;

  ValidateEmailEmptyFormatState({
    required this.emailValidatorMessage,
  });
}

class ValidateMobileNumberState extends ContactUsState {}

class ValidateMobileNumberEmptyFormatState extends ContactUsState {
  final String mobileNumberValidatorMessage;

  ValidateMobileNumberEmptyFormatState({
    required this.mobileNumberValidatorMessage,
  });

  @override
  List<Object> get props => [mobileNumberValidatorMessage];
}

class ValidateCountryState extends ContactUsState {
  final String countryName;
  final String countryCode;

  ValidateCountryState({
    required this.countryName,
    required this.countryCode,
  });

  @override
  List<Object> get props => [countryName, countryCode];
}

class ValidateCountryEmptyFormatState extends ContactUsState {
  final String countryValidatorMessage;

  ValidateCountryEmptyFormatState({
    required this.countryValidatorMessage,
  });

  @override
  List<Object> get props => [countryValidatorMessage];
}

class ValidateMessageState extends ContactUsState {}

class ValidateMessageEmptyFormatState extends ContactUsState {
  final String messageValidatorMessage;

  ValidateMessageEmptyFormatState({
    required this.messageValidatorMessage,
  });

  @override
  List<Object> get props => [messageValidatorMessage];
}

class DisplayDialogWhenSuccessAddContactUsState extends ContactUsState {
  final String message;

  DisplayDialogWhenSuccessAddContactUsState(this.message);

  @override
  List<Object> get props => [message];
}

final class ClearContactUsDataFieldsState extends ContactUsState {}

final class NavigateBackForClearDataState extends ContactUsState {}
