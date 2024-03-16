import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/request/reset_password_request.dart';
import 'package:city_eye/src/domain/entities/reset_password/reset_password.dart';
import 'package:city_eye/src/domain/usecase/invitation_reset_password_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final InvitationResetPasswordUseCase _invitationResetPasswordUseCase;

  ResetPasswordBloc(
    this._invitationResetPasswordUseCase,
  ) : super(ResetPasswordInitial()) {
    on<ValidatePasswordEvent>(_onValidatePasswordEvent);
    on<ValidatePasswordConfirmationEvent>(_onValidatePasswordConfirmationEvent);
    on<SubmitResetPasswordEvent>(_onSubmitResetPasswordEvent);
  }

  void _onValidatePasswordEvent(
      ValidatePasswordEvent event, Emitter<ResetPasswordState> emit) {
    if (event.password.isEmpty) {
      emit(InvalidPasswordState(errorMessage: S.current.thisFieldIsRequired));
    } else if (event.password.length < 6) {
      emit(InvalidPasswordState(
          errorMessage: S.current.passwordMustBeAtLeast6CharactersLong));
    } else if (event.password != event.confirmPassword &&
        event.confirmPassword.isNotEmpty) {
      emit(InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.passwordDoesNotMatch));
    } else {
      emit(ValidPasswordState());
      emit(ValidPasswordConfirmationState());
    }
  }

  void _onValidatePasswordConfirmationEvent(
      ValidatePasswordConfirmationEvent event,
      Emitter<ResetPasswordState> emit) {
    if (event.confirmPassword.isEmpty) {
      emit(
        InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.thisFieldIsRequired,
        ),
      );
    } else if (event.confirmPassword.length < 6) {
      emit(
        InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.passwordMustBeAtLeast6CharactersLong,
        ),
      );
    } else if (event.password != event.confirmPassword) {
      emit(
        InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.passwordDoesNotMatch,
        ),
      );
    } else {
      emit(
        ValidPasswordConfirmationState(),
      );
    }
  }

  void _onSubmitResetPasswordEvent(
      SubmitResetPasswordEvent event, Emitter<ResetPasswordState> emit) async {
    if (event.password.isEmpty) {
      emit(
        InvalidPasswordState(
          errorMessage: S.current.thisFieldIsRequired,
        ),
      );
    } else if (event.confirmPassword.isEmpty) {
      emit(
        InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.thisFieldIsRequired,
        ),
      );
    } else if (event.password.length < 6) {
      emit(InvalidPasswordState(
          errorMessage: S.current.passwordMustBeAtLeast6CharactersLong));
    } else if (event.confirmPassword.length < 6) {
      emit(
        InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.passwordMustBeAtLeast6CharactersLong,
        ),
      );
    } else if (event.password != event.confirmPassword) {
      emit(
        InvalidPasswordConfirmationState(
          errorConfirmMessage: S.current.passwordDoesNotMatch,
        ),
      );
    } else {
      emit(ShowLoadingState(isShow: true));
      final resetPasswordState = await _invitationResetPasswordUseCase(
          ResetPasswordRequest(
              invitationID: event.invitationId, password: event.password));

      if (resetPasswordState is DataSuccess<ResetPassword>) {
        ResetPassword resetPassword =
            resetPasswordState.data ?? const ResetPassword();
        emit(SubmitResetPasswordSuccessState(mobile: resetPassword.mobile));
      } else if (resetPasswordState is DataFailed) {
        emit(SubmitResetPasswordErrorState(
            errorMessage: resetPasswordState.message ?? ""));
      }
      emit(ShowLoadingState(isShow: false));
    }
  }
}
