import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_home_compound.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_notification_count.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/home_api_service.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/notification_count.dart';
import 'package:city_eye/src/domain/repositories/home_repository.dart';
import 'package:dio/dio.dart';

final class HomeRepositoryImplementation implements HomeRepository {
  final GetHomeCompoundAPIService getHomeCompoundAPIService;

  HomeRepositoryImplementation(this.getHomeCompoundAPIService);

  @override
  Future<DataState<HomeCompound>> getHomeCompound() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse =
          await getHomeCompoundAPIService.getHomeCompound(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess<HomeCompound>(
            message: httpResponse.data.responseMessage ?? "",
            data:
                (httpResponse.data.result ?? RemoteHomeCompound()).mapToDomain,
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<NotificationCount>> getUserUnseenNotificationsCount() async{
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse =
          await getHomeCompoundAPIService.getUserUnseenNotificationsCount(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess<NotificationCount>(
            message: httpResponse.data.responseMessage ?? "",
            data:
            (httpResponse.data.result ?? const RemoteNotificationCount()).mapToDomain(),
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }


}
