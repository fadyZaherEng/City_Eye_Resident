part of 'sign_in_bloc.dart';

@immutable
abstract class AbstractSignInEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class SignInEvent extends AbstractSignInEvent {
  final String mobileNumber;
  final String password;
  final String regionCode;

  SignInEvent({
    required this.mobileNumber,
    required this.password,
    required this.regionCode,
  });
}

class ChangeRememberMeValueEvent extends AbstractSignInEvent {
  final bool rememberMeValue;

  ChangeRememberMeValueEvent({
    required this.rememberMeValue,
  });
}

class RequestOTPEvent extends AbstractSignInEvent {
  final String phoneNumber;
  final int userId;
  final int compoundId;

  RequestOTPEvent({
    required this.phoneNumber,
    required this.userId,
    required this.compoundId,
  });
}

class NavigateToForgotPasswordScreenState extends AbstractSignInEvent {}

class NavigateToSignUpScreenEvent extends AbstractSignInEvent {}

class OpenUnitsBottomSheetEvent extends AbstractSignInEvent {
  final List<UserUnit> userUnits;
  final int userId;

  OpenUnitsBottomSheetEvent({
    required this.userUnits,
    required this.userId,
  });
}

class SelectCompoundEvent extends AbstractSignInEvent {
  final UserUnit userUnit;

  SelectCompoundEvent({
    required this.userUnit,
  });
}

class ValidateMobileNumberEvent extends AbstractSignInEvent {
  final String mobileNumber;
  final String regionCode;

  ValidateMobileNumberEvent({
    required this.mobileNumber,
    required this.regionCode,
  });
}

class ValidatePasswordEvent extends AbstractSignInEvent {
  final String password;

  ValidatePasswordEvent({
    required this.password,
  });
}

class GetRememberMeEvent extends AbstractSignInEvent {}

class NavigateToRegisterScreenEvent extends AbstractSignInEvent {
  final int userId;
  final List<UserUnit> userUnits;

  NavigateToRegisterScreenEvent({
    required this.userId,
    required this.userUnits,
  });
}
