import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_create_qr_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_configuration.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_details.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_history.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/qr_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/create_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/deactivate_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_history_request.dart';
import 'package:city_eye/src/domain/entities/qr/create_qr_response.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qr_response.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_details.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/repositories/qr_repository.dart';
import 'package:dio/dio.dart';

class QrRepositoryImplementation extends QrRepository {
  final QrAPIService _qrAPIService;

  QrRepositoryImplementation(this._qrAPIService);

  @override
  Future<DataState<QrResponse>> getQrCodeQuestions() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse = await _qrAPIService.getQrCodeQuestions(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess<QrResponse>(
            message: httpResponse.data.responseMessage ?? "",
            data:
                (httpResponse.data.result ?? RemoteQrResponse()).mapToDomain(),
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<CreateQrResponse>> createQrCode(
      CreateQrRequest createQrRequest) async {
    try {
      final request = CityEyeRequest().createRequest(createQrRequest);
      List<MultipartFile> files = [];
      for (int i = 0; i < createQrRequest.unitQrQuestionAnswers.length; i++) {
        if (createQrRequest.unitQrQuestionAnswers[i].controlTypeCode ==
                QuestionsCode.image &&
            createQrRequest.unitQrQuestionAnswers[i].value.isNotEmpty) {
          files.add(await MultipartFile.fromFile(
              createQrRequest.unitQrQuestionAnswers[i].value,
              filename:
                  "${createQrRequest.unitQrQuestionAnswers[i].id.toString()}.jpg"));
        }
      }

      final httpResponse = await _qrAPIService.createQrCode(
        files,
        jsonEncode(request.toMap()),
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess<CreateQrResponse>(
            message: httpResponse.data.responseMessage ?? "",
            data: (httpResponse.data.result ?? const RemoteCreateQrResponse())
                .mapToDomain(),
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<QrHistory>>> getQrHistory(
      QrHistoryRequest qrHistoryRequest) async {
    try {
      final request =
          CityEyeRequest<QrHistoryRequest>().createRequest(qrHistoryRequest);
      final httpResponse = await _qrAPIService.getQrHistory(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: e.message ?? "",
      );
    }
  }

  @override
  Future<DataState<QrHistory>> deactivateQrHistory(
      DeactivateQrRequest deactivateQrRequest) async {
    try {
      final request = CityEyeRequest<DeactivateQrRequest>()
          .createRequest(deactivateQrRequest);
      final httpResponse = await _qrAPIService.deactivateQrHistory(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteQrHistory())
                .mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: error.message ?? "",
      );
    }
  }

  @override
  Future<DataState<QrDetails>> getQrHistoryDetailsById(
      QrDetailsRequest qrDetailsRequest) async {
    try {
      final request =
          CityEyeRequest<QrDetailsRequest>().createRequest(qrDetailsRequest);
      final httpResponse = await _qrAPIService.getQrHistoryDetailsById(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteQrDetails())
                .mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: error.message ?? "",
      );
    }
  }

  @override
  Future<DataState<QrConfiguration>> getQrConfiguration() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse = await _qrAPIService.getQrConfiguration(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess<QrConfiguration>(
            message: httpResponse.data.responseMessage ?? "",
            data: (httpResponse.data.result ?? RemoteQrConfiguration())
                .mapToDomain(),
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }
}
