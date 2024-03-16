import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/survey_item_widget.dart';
import 'package:flutter/material.dart';

class SurveyItemsWidget extends StatelessWidget {
  final List<Survey> surveys;
  Function(Survey) onCardTap;
  final TextEditingController surveyTextEditingController;
  final Function(Survey, SurveyQuestionChoice) onActionSelected;
  final Function(Survey) onSendAction;

  SurveyItemsWidget({
    Key? key,
    this.surveys = const [],
    required this.onCardTap,
    required this.surveyTextEditingController,
    required this.onActionSelected,
    required this.onSendAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: surveys
                .map((element) => Padding(
                      padding: const EdgeInsets.only(
                          right: 12, left: 12, top: 10, bottom: 16),
                      child: SurveyItemWidget(
                        onChange: (value) {},
                        textEditingController: surveyTextEditingController,
                        onSelectAction: (survey, surveyAction) {
                          onActionSelected(survey, surveyAction);
                        },
                        onCardTap: (value) {
                          onCardTap(value);
                        },
                        survey: element,
                        selectedSurveyAction: element.selectAction,
                        onSendAction: (survey) {
                          onSendAction(survey);
                        },
                        boxShadows: const [
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: Offset(0, 1),
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
