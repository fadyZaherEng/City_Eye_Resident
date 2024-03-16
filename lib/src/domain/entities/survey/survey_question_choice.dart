import 'package:equatable/equatable.dart';

class SurveyQuestionChoice extends Equatable {
  final int id;
  final String value;
  final int countAnswer;
  final bool isSelected;
  final bool isNeedMoreInformation;
  final double percentage;
  final bool showPercentage;
  final int total;

  const SurveyQuestionChoice({
    this.id = 0,
    this.value = "",
    this.countAnswer = 0,
    this.isSelected = false,
    this.isNeedMoreInformation = false,
    this.percentage = 0,
    this.showPercentage = false,
    this.total = 0,
  });

   SurveyQuestionChoice copyWith({
      int? id,
      String? value,
      int? countAnswer,
      bool? isSelected,
      bool? isNeedMoreInformation,
      double? percentage,
      bool? showPercentage,
      int? total,
    }) {
      return SurveyQuestionChoice(
        id: id ?? this.id,
        value: value ?? this.value,
        countAnswer: countAnswer ?? this.countAnswer,
        isSelected: isSelected ?? this.isSelected,
        isNeedMoreInformation: isNeedMoreInformation ?? this.isNeedMoreInformation,
        percentage: percentage ?? this.percentage,
        showPercentage: showPercentage ?? this.showPercentage,
        total: total ?? this.total,
      );
    }


  @override
  List<Object?> get props => [id, value, countAnswer, isSelected];
}
