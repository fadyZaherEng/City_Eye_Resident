import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/requests/survey_submit_request.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/repositories/surveys_repository.dart';

class SubmitSurveyUseCase {
  final SurveysRepository _surveysRepository;

  SubmitSurveyUseCase(this._surveysRepository);

  Future<DataState<Survey>> call(
      SurveySubmitRequest surveySubmitRequest) async {
    return await _surveysRepository.submitSurvey(surveySubmitRequest);
  }
}
