import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_my_subscriptions.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_service_details_cart.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_submit_service_details_cart.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_details_cart_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_package_question_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/submit_service_details_cart_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/service_details_cart_api_service.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/service_details/submit_service_details_cart.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';
import 'package:city_eye/src/domain/repositories/service_details_cart_repository.dart';
import 'package:dio/dio.dart';

final class ServiceDetailsCartRepositoryImplementation
    implements ServiceDetailsCartRepository {
  final ServiceDetailsCartApiService _serviceDetailsCartApiService;

  ServiceDetailsCartRepositoryImplementation(
      this._serviceDetailsCartApiService);

  @override
  Future<DataState<List<ServiceDetailsCart>>> getServicePackages(
      ServiceDetailsCartRequest request) async {
    try {
      final servicePackageRequest =
          CityEyeRequest<ServiceDetailsCartRequest>().createRequest(request);
      final httpResponse =
          await _serviceDetailsCartApiService.getServicePackages(
        servicePackageRequest,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain,
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
  Future<DataState<List<MySubscription>>> getMySubscriptions() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse =
          await _serviceDetailsCartApiService.getMySubscriptions(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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
  Future<DataState<SubmitServiceDetailsCart>> submitServiceDetailsCart(
      List<SubmitServiceDetailsCartRequest>
          submitServiceDetailsCartRequest) async {
    try {
      final request = CityEyeRequest<List<SubmitServiceDetailsCartRequest>>()
          .createRequest(submitServiceDetailsCartRequest);
      List<MultipartFile> files = [];
      for (var servicePackage in submitServiceDetailsCartRequest) {
        final List<ServicePackageQuestionRequest> servicePackageQuestions =
            servicePackage.remoteServicePackagesQuestion;

        for (int i = 0; i < servicePackageQuestions.length; i++) {
          final ServicePackageQuestionRequest servicePackagesQuestion =
              servicePackageQuestions[i];
          if (servicePackagesQuestion.controlTypeCode == QuestionsCode.image &&
              servicePackagesQuestion.value.isNotEmpty) {
            String extractImageFormat =
                servicePackagesQuestion.value.split('.').last;
            files.add(
              await MultipartFile.fromFile(
                servicePackagesQuestion.value ?? "",
                filename: "${servicePackagesQuestion.id}.$extractImageFormat",
              ),
            );
          }
        }
      }
      final httpResponse = await _serviceDetailsCartApiService
          .submitServiceDetailsCart(jsonEncode(request.toMap()), files);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ??
                    const RemoteSubmitServiceDetailsCart())
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
