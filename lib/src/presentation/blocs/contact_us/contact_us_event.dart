part of 'contact_us_bloc.dart';

abstract class ContactUsEvent extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class ContactUsSendEvent extends ContactUsEvent {
  final AddContactUsRequest addContactUsRequest;
  final String countryName;

  ContactUsSendEvent(
    this.addContactUsRequest,
    this.countryName,
  );

  @override
  List<Object> get props => [addContactUsRequest];
}

class FetchCountriesEvent extends ContactUsEvent {}

class SetCountryEvent extends ContactUsEvent {
  final String countryName;
  final String countryCode;

  SetCountryEvent({
    required this.countryName,
    required this.countryCode,
  });

  @override
  List<Object> get props => [countryName, countryCode];
}

class OpenCountryBottomSheetEvent extends ContactUsEvent {}

class NavigateBackEvent extends ContactUsEvent {}

class ValidateUsernameEvent extends ContactUsEvent {
  final String name;

  ValidateUsernameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class ValidateEmailEvent extends ContactUsEvent {
  final String email;

  ValidateEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ValidateMobileNumberEvent extends ContactUsEvent {
  final String mobileNo;

  ValidateMobileNumberEvent(this.mobileNo);

  @override
  List<Object> get props => [mobileNo];
}

class ValidateCountryEvent extends ContactUsEvent {
  final String countryName;
  final String countryCode;

  ValidateCountryEvent(this.countryCode, this.countryName);

  @override
  List<Object> get props => [countryName, countryCode];
}

class ValidateMessageEvent extends ContactUsEvent {
  final String message;

  ValidateMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}

final class DisplayDialogWhenSuccessAddContactUsEvent extends ContactUsEvent {
  final String message;

  DisplayDialogWhenSuccessAddContactUsEvent(this.message);

  @override
  List<Object> get props => [message];
}

final class ClearContactUsDataFieldsEvent extends ContactUsEvent {}

final class NavigateBackForClearDataEvent extends ContactUsEvent {}
