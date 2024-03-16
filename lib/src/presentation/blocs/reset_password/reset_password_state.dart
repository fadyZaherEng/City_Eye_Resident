part of 'reset_password_bloc.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ShowLoadingState extends ResetPasswordState {
  final bool isShow;

  ShowLoadingState({
    required this.isShow,
  });
}

class ValidPasswordState extends ResetPasswordState {}

class InvalidPasswordState extends ResetPasswordState {
  final String errorMessage;

  InvalidPasswordState({
    required this.errorMessage,
  });
}

class ValidPasswordConfirmationState extends ResetPasswordState {}

class InvalidPasswordConfirmationState extends ResetPasswordState {
  final String errorConfirmMessage;

  InvalidPasswordConfirmationState({
    required this.errorConfirmMessage,
  });
}

class SubmitResetPasswordSuccessState extends ResetPasswordState {
  final String mobile;

  SubmitResetPasswordSuccessState({
    required this.mobile,
  });
}

class SubmitResetPasswordErrorState extends ResetPasswordState {
  final String errorMessage;

  SubmitResetPasswordErrorState({
    required this.errorMessage,
  });
}

class NavigateBackState extends ResetPasswordState {}