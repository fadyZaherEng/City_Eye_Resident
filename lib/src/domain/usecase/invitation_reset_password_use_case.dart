import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/request/reset_password_request.dart';
import 'package:city_eye/src/domain/entities/reset_password/reset_password.dart';
import 'package:city_eye/src/domain/repositories/reset_password_repository.dart';

class InvitationResetPasswordUseCase {
  final ResetPasswordRepository _resetPasswordRepository;

  InvitationResetPasswordUseCase(this._resetPasswordRepository);

  Future<DataState<ResetPassword>> call(ResetPasswordRequest resetPasswordRequest) async {
    return await _resetPasswordRepository.resetPassword(resetPasswordRequest);
  }
}