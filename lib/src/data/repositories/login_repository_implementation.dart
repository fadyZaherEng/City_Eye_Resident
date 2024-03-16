import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/login_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/change_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/forgot_password_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/request/login_request.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/repositories/login_repository.dart';
import 'package:dio/dio.dart';

class LoginRepositoryImplementation extends LoginRepository {
  final LoginAPIService _loginAPIService;

  LoginRepositoryImplementation(this._loginAPIService);

  @override
  Future<DataState<User>> login(LoginRequest loginRequest) async {
    try {
      CityEyeRequest<LoginRequest> request =
          CityEyeRequest<LoginRequest>().createRequest(loginRequest);
      final httpResponse = await _loginAPIService.login(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data:
                (httpResponse.data.result ?? const RemoteUser()).mapToDomain(),
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

  @override
  Future<DataState<String>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    try {
      CityEyeRequest<ForgotPasswordRequest> request =
          await CityEyeRequest<ForgotPasswordRequest>()
              .createRequest(forgotPasswordRequest);
      final httpResponse = await _loginAPIService.forgotPassword(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: null,
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

  @override
  Future<DataState<String>> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    try {
      CityEyeRequest<ChangePasswordRequest> request =
          await CityEyeRequest<ChangePasswordRequest>()
              .createRequest(changePasswordRequest);
      final httpResponse = await _loginAPIService.changePassword(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: null,
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
