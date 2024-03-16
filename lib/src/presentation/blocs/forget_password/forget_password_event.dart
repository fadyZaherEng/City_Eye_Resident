part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [
        identityHashCode(
          this,
        ),
      ];
}

class ResetPasswordEvent extends ForgetPasswordEvent {
  final String email;

  ResetPasswordEvent({
    required this.email,
  });
}

class ValidateEmailEvent extends ForgetPasswordEvent {
  final String email;

  ValidateEmailEvent({
    required this.email,
  });
}
