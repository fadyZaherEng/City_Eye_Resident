import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/request/reset_password_request.dart';
import 'package:city_eye/src/domain/entities/reset_password/reset_password.dart';

abstract class ResetPasswordRepository {
  Future<DataState<ResetPassword>> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
}
