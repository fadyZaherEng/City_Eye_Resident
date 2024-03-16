import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/survey_items_widget.dart';
import 'package:flutter/material.dart';

class SurveySection extends StatelessWidget {
  final List<Survey> surveys;
  final Function(Survey) onCardTap;
  final TextEditingController surveyTextEditingController;
  final Function(Survey, SurveyQuestionChoice) onActionSelected;
  final Function(Survey) onSendAction;
  final Function() onTapSeeAll;

  const SurveySection(
      {Key? key,
      this.surveys = const [],
      required this.onCardTap,
      required this.surveyTextEditingController,
      required this.onActionSelected,
      required this.onSendAction,
      required this.onTapSeeAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
          child: Row(
            children: [
              Text(S.of(context).survey,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorSchemes.black, letterSpacing: -0.24)),
              const Expanded(
                child: SizedBox(),
              ),
              InkWell(
                onTap: () {
                  onTapSeeAll();
                },
                child: Text(S.of(context).seeAll,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(letterSpacing: -0.24)),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SurveyItemsWidget(
          surveys: surveys,
          onCardTap: (value) {
            onCardTap(value);
          },
          onSendAction: (survey) {
            onSendAction(survey);
          },
          onActionSelected: (survey, surveyAction) {
            onActionSelected(survey, surveyAction);
          },
          surveyTextEditingController: surveyTextEditingController,
        ),
      ],
    );
  }
}
