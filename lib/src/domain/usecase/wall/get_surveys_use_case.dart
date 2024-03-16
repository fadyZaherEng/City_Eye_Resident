import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/repositories/surveys_repository.dart';

class GetSurveysUseCase {
  final SurveysRepository _surveysRepository;

  GetSurveysUseCase(this._surveysRepository);

  Future<DataState<List<Survey>>> call() async {
    return await _surveysRepository.getSurveys();
  }
}
