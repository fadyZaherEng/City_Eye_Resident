import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/entity/remote_notification_item.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/notification_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/request/notification_seen_request.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/repositories/notification_repository.dart';
import 'package:dio/dio.dart';

final class NotificationRepositoryImplementation
    implements NotificationRepository {
  final NotificationApiService _notificationApiService;

  NotificationRepositoryImplementation(this._notificationApiService);

  @override
  Future<DataState<List<NotificationItem>>> getNotifications() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse =
          await _notificationApiService.getNotifications(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        return DataSuccess(
          data: (httpResponse.data.result ?? const []).mapToDomain(),
          message: httpResponse.data.responseMessage ?? "",
        );
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
  Future<DataState<NotificationItem>> getNotificationDetails(
      NotificationDetailsRequest notificationDetailsRequest) async {
    try {
      final request = CityEyeRequest<NotificationDetailsRequest>()
          .createRequest(notificationDetailsRequest);
      final httpResponse =
          await _notificationApiService.getNotificationById(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        return DataSuccess(
          data: (httpResponse.data.result ?? const RemoteNotificationItem())
              .mapToDomain(),
          message: httpResponse.data.responseMessage ?? "",
        );
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
  Future<DataState> updateNotificationAsSeen(NotificationSeenRequest notificationSeenRequest ) async {
    try {
      final request = CityEyeRequest<NotificationSeenRequest>()
          .createRequest(notificationSeenRequest);
      final httpResponse =
          await _notificationApiService.updateNotificationAsSeen(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        return DataSuccess(
          message: httpResponse.data.responseMessage ?? "",
          data: "",
        );
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
