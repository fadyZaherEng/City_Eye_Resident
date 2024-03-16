import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/landing/entity/remote_landing.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/landing/landing_api_service.dart';
import 'package:city_eye/src/domain/entities/landing/landing.dart';
import 'package:city_eye/src/domain/repositories/landing_repository.dart';
import 'package:dio/dio.dart';

class LandingRepositoryImplementation extends LandingRepository {
  final LandingAPIService _landingAPIService;

  LandingRepositoryImplementation(this._landingAPIService);

  @override
  Future<DataState<Landing>> getLanding() async {
    try {
      CityEyeRequest request = await CityEyeRequest().createRequest(null);
      final httpResponse = await _landingAPIService.getLanding(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? RemoteLanding()).mapToDomain(),
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
