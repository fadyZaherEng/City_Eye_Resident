import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_city_compound.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_compound_unit.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_edit_mobile_number.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/entity/remote_otp.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/register_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/compound_units_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/edit_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/request_otp_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/validate_mobile_number_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/verify_otp_request.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/entities/register/edit_mobile_number.dart';
import 'package:city_eye/src/domain/entities/register/otp.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/repositories/register_repository.dart';
import 'package:dio/dio.dart';

class RegisterRepositoryImplementation extends RegisterRepository {
  final RegisterAPIService _registerAPIService;

  RegisterRepositoryImplementation(this._registerAPIService);

  @override
  Future<DataState<List<CityCompound>>> getCityCompounds() async {
    try {
      CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _registerAPIService.getCityCompounds(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? []).mapToDomain(),
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
  Future<DataState<List<CompoundUnit>>> getCompoundUnits(
      CompoundUnitsRequest compoundUnitsRequest, int userId) async {
    try {
      CityEyeRequest<CompoundUnitsRequest> request =
          CityEyeRequest<CompoundUnitsRequest>()
              .createRequest(compoundUnitsRequest);
      if (userId != -1) {
        request.userId = userId;
      }
      final httpResponse = await _registerAPIService.getCompoundUnits(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? []).mapToDomain(),
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
  Future<DataState<OTP>> register(
      RegisterRequest registerRequest, int userId) async {
    try {
      CityEyeRequest<RegisterRequest> request =
          CityEyeRequest<RegisterRequest>().createRequest(registerRequest);
      List<MultipartFile> files = [];
      for (int i = 0; i < registerRequest.files.length; i++) {
        if (registerRequest.files[i].controlTypeCode ==
                QuestionsCode.multiImage &&
            registerRequest.files[i].value.isNotEmpty) {
          List<String> paths = registerRequest.files[i].value.split(',');
          for (int j = 0; j < paths.length; j++) {
            files.add(await MultipartFile.fromFile(paths[j],
                filename: "${registerRequest.files[i].id.toString()}.jpg"));
          }
        } else {
          if (registerRequest.files[i].value.isNotEmpty) {
            files.add(await MultipartFile.fromFile(
                registerRequest.files[i].value,
                filename:
                    "${registerRequest.files[i].id.toString()}.${registerRequest.files[i].value.split('.').last}"));
          }
        }
      }
      if (userId != -1) {
        request.userId = userId;
      }
      final httpResponse = await _registerAPIService.register(
        jsonEncode(request.toMap()),
        files,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? RemoteOTP()).mapToDomain(),
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
  Future<DataState<OTP>> requestOTP(
      RequestOTPRequest requestOTPRequest, int compoundId) async {
    try {
      CityEyeRequest<RequestOTPRequest> request =
          CityEyeRequest<RequestOTPRequest>().createRequest(requestOTPRequest);
      request.compoundId = compoundId;
      final httpResponse = await _registerAPIService.requestOTP(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? RemoteOTP()).mapToDomain(),
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
  Future<DataState> validateMobileNumber(
      ValidateMobileNumberRequest validateMobileNumberRequest) async {
    try {
      CityEyeRequest<ValidateMobileNumberRequest> request =
          CityEyeRequest<ValidateMobileNumberRequest>()
              .createRequest(validateMobileNumberRequest);
      final httpResponse =
          await _registerAPIService.validateMobileNumber(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? ""),
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
  Future<DataState<User>> verifyOTP(
      VerifyOTPRequest verifyOTPRequest, int userId) async {
    try {
      CityEyeRequest<VerifyOTPRequest> request =
          CityEyeRequest<VerifyOTPRequest>().createRequest(verifyOTPRequest);
      request.userId = userId;
      final httpResponse = await _registerAPIService.verifyOTP(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? RemoteUser()).mapToDomain(),
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
  Future<DataState<EditMobileNumber>> editMobileNumber(
      EditMobileNumberRequest editMobileNumberRequest) async {
    try {
      CityEyeRequest<EditMobileNumberRequest> request =
          CityEyeRequest<EditMobileNumberRequest>()
              .createRequest(editMobileNumberRequest);
      final httpResponse = await _registerAPIService.editMobileNumber(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteEditMobileNumber())
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
