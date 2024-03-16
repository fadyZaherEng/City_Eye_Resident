import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/badge_identity_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/entity/remote_badge_identity.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_identity.dart';
import 'package:city_eye/src/domain/repositories/badge_identity_repository.dart';
import 'package:dio/dio.dart';

class BadgeIdentityRepositoryImplementation implements BadgeIdentityRepository {
  final BadgeIdentityApiServices _badgeIdentityApiServices;

  BadgeIdentityRepositoryImplementation(this._badgeIdentityApiServices);

  @override
  Future<DataState<BadgeIdentity>> getBadgeIdentity() async {
    try {
      CityEyeRequest request = await CityEyeRequest().createRequest(null);
      final httpResponse = await _badgeIdentityApiServices.getBadgeIdentity(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const RemoteBadgeIdentity()).mapToDomain(),
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
