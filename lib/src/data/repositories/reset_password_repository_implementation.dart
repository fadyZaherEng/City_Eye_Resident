import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/entity/remote_reset_password.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/request/reset_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/reset_password_services.dart';
import 'package:city_eye/src/domain/entities/reset_password/reset_password.dart';
import 'package:city_eye/src/domain/repositories/reset_password_repository.dart';
import 'package:dio/dio.dart';

class ResetPasswordRepositoryImplementation implements ResetPasswordRepository {
  final ResetPasswordService _resetPasswordService;

  ResetPasswordRepositoryImplementation(this._resetPasswordService);

  @override
  Future<DataState<ResetPassword>> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      CityEyeRequest<ResetPasswordRequest> request =
          CityEyeRequest<ResetPasswordRequest>().createRequest(resetPasswordRequest);

      final httpResponse =
          await _resetPasswordService.invitationResetPassword(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteResetPassword())
                .mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
