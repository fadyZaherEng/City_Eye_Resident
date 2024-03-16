part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class ValidatePasswordEvent extends ResetPasswordEvent {
  final String password;
  final String confirmPassword;

  ValidatePasswordEvent({
    required this.password,
    required this.confirmPassword,
  });
}

class ValidatePasswordConfirmationEvent extends ResetPasswordEvent {
  final String password;
  final String confirmPassword;

  ValidatePasswordConfirmationEvent({
    required this.password,
    required this.confirmPassword,
  });
}

class SubmitResetPasswordEvent extends ResetPasswordEvent {
  final String password;
  final String confirmPassword;
  final int invitationId;

  SubmitResetPasswordEvent({
    required this.password,
    required this.confirmPassword,
    required this.invitationId,
  });
}

class NavigateBackEvent extends ResetPasswordEvent {}