import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/delegated_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/entity/remote_delegated.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/entity/remote_submit_delegation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delete_delegated_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/submit_delegated_request.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/domain/entities/delegated/submit_delegation.dart';
import 'package:city_eye/src/domain/repositories/delegated_repository.dart';
import 'package:dio/dio.dart';

class DelegatedRepositoryImplementation extends DelegatedRepository {
  final DelegatedAPIService _delegatedAPIService;

  DelegatedRepositoryImplementation(this._delegatedAPIService);

  @override
  Future<DataState<List<Delegated>>> getDelegatedList() async {
    try {
      CityEyeRequest request = await CityEyeRequest().createRequest(null);
      final httpResponse = await _delegatedAPIService.getDelegatedList(request);
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
  Future<DataState> deleteDelegated(
      DeleteDelegatedRequest deleteDelegatedRequest) async {
    try {
      CityEyeRequest<DeleteDelegatedRequest> request =
          await CityEyeRequest<DeleteDelegatedRequest>()
              .createRequest(deleteDelegatedRequest);
      final httpResponse = await _delegatedAPIService.deleteDelegated(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            // data: (httpResponse.data.result ?? []).mapToDomain(),
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
  Future<DataState<SubmitDelegation>> submitDelegation(
      String ownerIDPath,
      String authIDPath,
      Uint8List? ownerSignaturePath,
      Uint8List? authSignaturePath,
      SubmitDelegatedRequest submitDelegatedRequest) async {
    try {
      List<MultipartFile> files = [];
      CityEyeRequest<SubmitDelegatedRequest> request =
          CityEyeRequest<SubmitDelegatedRequest>()
              .createRequest(submitDelegatedRequest);

      MultipartFile ownerImage = ownerIDPath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(ownerIDPath,
              filename: "ownerAttachment.jpg");

      MultipartFile authImage = authIDPath.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromFile(authIDPath,
              filename: "authAttachment.jpg");

      MultipartFile ownerSignature = ownerSignaturePath!.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromBytes(ownerSignaturePath,
              filename: "ownerSignatureAttachment.jpg");

      MultipartFile authSignature = authSignaturePath!.isEmpty
          ? MultipartFile.fromBytes(<int>[])
          : await MultipartFile.fromBytes(authSignaturePath,
              filename: "authSignatureAttachment.jpg");

      if (ownerIDPath.isNotEmpty) {
        files.add(ownerImage);
      }
      if (authIDPath.isNotEmpty) {
        files.add(authImage);
      }
      if (ownerSignaturePath.isNotEmpty) {
        files.add(ownerSignature);
      }
      if (authSignaturePath.isNotEmpty) {
        files.add(authSignature);
      }

      for (int i = 0; i < submitDelegatedRequest.ownerExtraField.length; i++) {
        if (submitDelegatedRequest.ownerExtraField[i].value.isNotEmpty &&
            submitDelegatedRequest.ownerExtraField[i].controlTypeCode ==
                QuestionsCode.image &&
            isUrl(submitDelegatedRequest.ownerExtraField[i].value) == false) {
          files.add(await MultipartFile.fromFile(
              submitDelegatedRequest.ownerExtraField[i].value,
              filename: "${submitDelegatedRequest.ownerExtraField[i].id}.jpg"));
        } else if (submitDelegatedRequest.ownerExtraField[i].controlTypeCode ==
                QuestionsCode.image &&
            isUrl(submitDelegatedRequest.ownerExtraField[i].value) == false) {
          submitDelegatedRequest.ownerExtraField[i] =
              submitDelegatedRequest.ownerExtraField[i].copyWith(
            value: "",
          );
        }
      }

      for (int i = 0; i < submitDelegatedRequest.authExtraField.length; i++) {
        if (submitDelegatedRequest.authExtraField[i].value.isNotEmpty &&
            submitDelegatedRequest.authExtraField[i].controlTypeCode ==
                QuestionsCode.image &&
            isUrl(submitDelegatedRequest.authExtraField[i].value) == false) {
          files.add(await MultipartFile.fromFile(
              submitDelegatedRequest.authExtraField[i].value,
              filename: "${submitDelegatedRequest.authExtraField[i].id}.jpg"));
        } else if (submitDelegatedRequest.authExtraField[i].controlTypeCode ==
                QuestionsCode.image &&
            isUrl(submitDelegatedRequest.authExtraField[i].value) == false) {
          submitDelegatedRequest.authExtraField[i] =
              submitDelegatedRequest.authExtraField[i].copyWith(
            value: "",
          );
        }
      }

      final httpResponse = await _delegatedAPIService.submitDelegation(
        files,
        jsonEncode(request.toMap()),
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteSubmitDelegation())
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
