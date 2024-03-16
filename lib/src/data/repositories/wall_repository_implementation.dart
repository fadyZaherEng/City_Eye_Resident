import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/entity/remote_wall.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/request/wall_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/wall_api_service.dart';
import 'package:city_eye/src/domain/entities/wall/wall.dart';
import 'package:city_eye/src/domain/repositories/wall_repository.dart';
import 'package:dio/dio.dart';

class WallRepositoryImplementation extends WallRepository {
  final WallAPIService _wallAPIService;

  WallRepositoryImplementation(this._wallAPIService);

  @override
  Future<DataState<List<Wall>>> getWallList() async {
    try {
      CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _wallAPIService.getWallList(request);
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
  Future<DataState<Wall>> getWallDetails(
      WallDetailsRequest wallDetailsRequest) async {
    try {
      CityEyeRequest<WallDetailsRequest> request =
          CityEyeRequest<WallDetailsRequest>()
              .createRequest(wallDetailsRequest);
      final httpResponse = await _wallAPIService.getWallDetails(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? RemoteWall()).mapToDomain(),
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
