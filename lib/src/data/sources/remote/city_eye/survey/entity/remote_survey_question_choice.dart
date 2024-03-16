import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_survey_question_choice.g.dart';

@JsonSerializable()
class RemoteSurveyQuestionChoice {
  final int? id;
  final String? value;
  final int? countAnswer;

  RemoteSurveyQuestionChoice({
    required this.id,
    required this.value,
    required this.countAnswer,
  });

  factory RemoteSurveyQuestionChoice.fromJson(Map<String, dynamic> json) =>
      _$RemoteSurveyQuestionChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSurveyQuestionChoiceToJson(this);
}

extension RemoteSurveyQuestionChoiceExtension on RemoteSurveyQuestionChoice {
  SurveyQuestionChoice mapToDomain() => SurveyQuestionChoice(
        id: id?? 0,
        value: value ?? "",
        countAnswer: countAnswer ?? 0,
      );
}

extension RemoteSurveyQuestionChoiceListExtension on List<RemoteSurveyQuestionChoice>? {
  List<SurveyQuestionChoice> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}