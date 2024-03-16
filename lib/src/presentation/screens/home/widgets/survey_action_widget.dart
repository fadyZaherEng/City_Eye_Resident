import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:flutter/material.dart';

class SurveyActionWidget extends StatelessWidget {
  final List<SurveyQuestionChoice> actions;
  final Function(SurveyQuestionChoice) onSelectAction;

  const SurveyActionWidget(
      {Key? key, required this.actions, required this.onSelectAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions
                .map((element) => Row(
                      children: [
                        CustomButtonBorderWidget(
                          onTap: () {
                            onSelectAction(element);
                          },
                          buttonTitle: element.value,
                          isSelected: element.isSelected,
                        ),
                        const SizedBox(
                          width: 32,
                        )
                      ],
                    ))
                .toList(),
          ),
        ));
  }
}
