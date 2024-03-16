part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {
  final String message;

  ChangePasswordSuccessState({
    required this.message,
  });
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordErrorState({
    required this.errorMessage,
  });
}

class OldPasswordEmptyFormatState extends ChangePasswordState {
  final String oldPasswordValidatorMessage;

  OldPasswordEmptyFormatState({
    required this.oldPasswordValidatorMessage,
  });
}

class NewPasswordEmptyFormatState extends ChangePasswordState {
  final String newPasswordValidatorMessage;

  NewPasswordEmptyFormatState({
    required this.newPasswordValidatorMessage,
  });
}

class ConfirmPasswordEmptyFormatState extends ChangePasswordState {
  final String confirmPasswordValidatorMessage;

  ConfirmPasswordEmptyFormatState({
    required this.confirmPasswordValidatorMessage,
  });
}

class NewPasswordMostBeMustBeSixCharacterFormatState
    extends ChangePasswordState {
  final String newPasswordValidatorMessage;

  NewPasswordMostBeMustBeSixCharacterFormatState({
    required this.newPasswordValidatorMessage,
  });
}

class ConfirmPasswordNotMatchNewPasswordFormatState
    extends ChangePasswordState {
  final String confirmPasswordValidatorMessage;

  ConfirmPasswordNotMatchNewPasswordFormatState({
    required this.confirmPasswordValidatorMessage,
  });
}

class OldPasswordFormatValidState extends ChangePasswordState {}

class NewPasswordFormatValidState extends ChangePasswordState {}

class ConfirmPasswordFormatValidState extends ChangePasswordState {}

class NavigationBackState extends ChangePasswordState {}

class ShowLoadingState extends ChangePasswordState {}

class HideLoadingState extends ChangePasswordState {}