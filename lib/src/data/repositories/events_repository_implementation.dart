import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/entity/remote_event_data.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/entity/remote_event_details_data.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/events_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/event/event_details_data.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';
import 'package:city_eye/src/domain/repositories/events_repository.dart';
import 'package:dio/dio.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/entity/remote_submit_event.dart';

final class EventsRepositoryImplementation extends EventsRepository {
  final EventsAPIServices eventsAPIServices;

  EventsRepositoryImplementation(this.eventsAPIServices);

  @override
  Future<DataState<EventData>> getEvents() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse = await eventsAPIServices.getEvents(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            message: httpResponse.data.responseMessage ?? "",
            data: (httpResponse.data.result ?? RemoteEventData()).mapToDomain,
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
  Future<DataState<SubmitEvent>> submitEvent(
      SubmitEventRequest submitEventRequest) async {
    try {
      CityEyeRequest<SubmitEventRequest> request =
          CityEyeRequest<SubmitEventRequest>()
              .createRequest(submitEventRequest);
      List<MultipartFile> files = [];
      for (int i = 0; i < submitEventRequest.questionAnswer.length; i++) {
        if (submitEventRequest.questionAnswer[i].value.isNotEmpty &&
            submitEventRequest.questionAnswer[i].controlTypeCode ==
                QuestionsCode.image &&
            isUrl(submitEventRequest.questionAnswer[i].value) == false) {
          files.add(await MultipartFile.fromFile(
              submitEventRequest.questionAnswer[i].value,
              filename: "${submitEventRequest.questionAnswer[i].id}.jpg"));
        }
      }
      final httpResponse = await eventsAPIServices.submitEvent(
        jsonEncode(request.toMap()),
        files,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            message: httpResponse.data.responseMessage ?? "",
            data:
                (httpResponse.data.result ?? RemoteSubmitEvent()).mapToDomain(),
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
  Future<DataState<EventDetailsData>> getEventDetails(
      EventDetailsRequest eventDetailsRequest) async {
    try {
      CityEyeRequest<EventDetailsRequest> request =
          CityEyeRequest<EventDetailsRequest>().createRequest(
        eventDetailsRequest,
      );
      final httpResponse = await eventsAPIServices.getEventDetails(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            message: httpResponse.data.responseMessage ?? "",
            data: (httpResponse.data.result ?? RemoteEventDetailsData()).mapToDomain,
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );    }
  }
}
