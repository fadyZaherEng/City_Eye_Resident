part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final List<UserUnit> userUnits;
  final int userId;

  SignInSuccessState({
    required this.userUnits,
    required this.userId,
  });
}

class NavigateToOTPScreenState extends SignInState {
  final String phoneNumber;
  final int userId;
  final int compoundID;
  final String otp;

  NavigateToOTPScreenState({
    required this.phoneNumber,
    required this.userId,
    required this.compoundID,
    required this.otp,
  });
}

class SignInErrorState extends SignInState {
  final String errorMessage;
  final String icon;

  SignInErrorState({
    required this.errorMessage,
    required this.icon,
  });
}

class ChangeRememberMeValueState extends SignInState {
  final bool rememberMeValue;

  ChangeRememberMeValueState({
    required this.rememberMeValue,
  });
}

class NavigateToForgotPasswordScreenEvent extends SignInState {}

class NavigateToSignUpScreenState extends SignInState {}

class OpenUnitsBottomSheetState extends SignInState {
  final List<UserUnit> userUnits;
  final int userId;

  OpenUnitsBottomSheetState({
    required this.userUnits,
    required this.userId,
  });
}

class SelectCompoundState extends SignInState {}

class MobileNumberEmptyFormatState extends SignInState {
  final String mobileNumberValidatorMessage;

  MobileNumberEmptyFormatState({
    required this.mobileNumberValidatorMessage,
  });
}

class PasswordEmptyFormatState extends SignInState {
  final String passwordValidatorMessage;

  PasswordEmptyFormatState({
    required this.passwordValidatorMessage,
  });
}

class MobileNumberFormatValidState extends SignInState {}

class PasswordFormatValidState extends SignInState {}

class ValidSignInFormState extends SignInState {
  final String phoneNumber;
  final String password;

  ValidSignInFormState({
    required this.phoneNumber,
    required this.password,
  });
}

class GetRememberMeState extends SignInState {
  final bool rememberMe;

  GetRememberMeState({required this.rememberMe});
}

class NavigateToRegisterScreenState extends SignInState {
  final int userId;
  final List<UserUnit> userUnits;

  NavigateToRegisterScreenState({
    required this.userId,
    required this.userUnits,
  });
}
