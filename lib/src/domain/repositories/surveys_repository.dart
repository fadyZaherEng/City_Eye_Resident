import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/requests/survey_submit_request.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';

abstract class SurveysRepository {
  Future<DataState<List<Survey>>> getSurveys();

  Future<DataState<Survey>> submitSurvey(SurveySubmitRequest surveySubmitRequest);
}
