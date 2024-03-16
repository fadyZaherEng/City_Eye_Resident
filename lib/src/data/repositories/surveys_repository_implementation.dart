import 'dart:convert';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_survey.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/requests/survey_submit_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/survey_api_services.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/repositories/surveys_repository.dart';
import 'package:dio/dio.dart';

final class SurveysRepositoryImplementation extends SurveysRepository {
  final SurveyAPIServices surveyAPIServices;

  SurveysRepositoryImplementation(this.surveyAPIServices);

  @override
  Future<DataState<List<Survey>>> getSurveys() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse = await surveyAPIServices.getSurveyList(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            message: httpResponse.data.responseMessage ?? "",
            data: (httpResponse.data.result ?? []).mapToDomain,
          );
        }
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        message: S.current.badResponse,
        error: error,
      );
    }
  }

  @override
  Future<DataState<Survey>> submitSurvey(
      SurveySubmitRequest surveySubmitRequest) async {
    try {
      final request = CityEyeRequest().createRequest(surveySubmitRequest);
      final httpResponse = await surveyAPIServices.submitSurvey(
        jsonEncode(request.toMap()),
        [],
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            message: httpResponse.data.responseMessage ?? "",
            data:
                (httpResponse.data.result ?? const RemoteSurvey()).mapToDomain,
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
