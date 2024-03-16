part of 'change_password_bloc.dart';

@immutable
abstract class AbstractChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(this),
      ];
}

class ChangePasswordEvent extends AbstractChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class ValidateOldPasswordEvent extends AbstractChangePasswordEvent {
  final String oldPassword;

  ValidateOldPasswordEvent({
    required this.oldPassword,
  });
}

class ValidateNewPasswordEvent extends AbstractChangePasswordEvent {
  final String newPassword;

  ValidateNewPasswordEvent({
    required this.newPassword,
  });
}

class ValidateConfirmPasswordEvent extends AbstractChangePasswordEvent {
  final String newPassword;
  final String confirmPassword;

  ValidateConfirmPasswordEvent({
    required this.newPassword,
    required this.confirmPassword,
  });
}

class NavigationBackEvent extends AbstractChangePasswordEvent {}
