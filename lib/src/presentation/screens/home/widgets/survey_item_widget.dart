import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/domain/entities/survey/survey.dart';
import 'package:city_eye/src/domain/entities/survey/survey_question_choice.dart';
import 'package:city_eye/src/presentation/screens/home/widgets/survey_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SurveyItemWidget extends StatefulWidget {
  final Survey survey;
  final TextEditingController textEditingController;
  final Function(Survey, SurveyQuestionChoice) onSelectAction;
  final Function(Survey)? onSendAction;
  final SurveyQuestionChoice? selectedSurveyAction;
  final Function(String) onChange;
  final double width;
  final List<BoxShadow>? boxShadows;
  final Function(Survey)? onCardTap;
  final Color borderColor;

  const SurveyItemWidget({
    Key? key,
    required this.survey,
    required this.textEditingController,
    required this.onSelectAction,
    required this.onChange,
    this.onCardTap,
    this.onSendAction,
    this.selectedSurveyAction,
    this.width = 360,
    this.boxShadows,
    this.borderColor = ColorSchemes.white,
  }) : super(key: key);

  @override
  State<SurveyItemWidget> createState() => _SurveyItemWidgetState();
}

class _SurveyItemWidgetState extends State<SurveyItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onCardTap == null ? () {} : widget.onCardTap!(widget.survey);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: ColorSchemes.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: widget.borderColor, width: 1),
            boxShadow: widget.boxShadows,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.survey.lable.trim(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorSchemes.black, letterSpacing: -0.24),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _defaultSize(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    SvgPicture.asset(ImagePaths.grayCalendar),
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).surveyExpireDate,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.gray, letterSpacing: -0.24),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      convertTimestampToDateFormat(widget.survey.endDate),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.black, letterSpacing: -0.24),
                    ),
                  ],
                ),
              ),
              _defaultSize(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Divider(
                  color: ColorSchemes.lightGray,
                  height: 1,
                ),
              ),
              _defaultSize(),
              SurveyActionWidget(
                  onSelectAction: (surveyAction) {
                    widget.onSelectAction(widget.survey, surveyAction);
                  },
                  actions: widget.survey.surveyQuestionChoice),
              _defaultSize(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Visibility(
                      visible:
                          widget.selectedSurveyAction?.showPercentage ?? false,
                      child: Column(
                        children: [
                          ...widget.survey.surveyQuestionChoice
                              .map((element) => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            element.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: ColorSchemes.black),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${element.countAnswer.toString()} %",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color:
                                                            ColorSchemes.black),
                                              ),
                                              // const SizedBox(width: 2),
                                              // SvgPicture.asset(
                                              //     ImagePaths.profileGroup)
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      LinearPercentIndicator(
                                        padding: const EdgeInsets.all(0),
                                        percent:
                                            (element.countAnswer / 100) > 1.0
                                                ? 1.0
                                                : (element.countAnswer / 100),
                                        backgroundColor: const Color.fromRGBO(
                                            241, 241, 241, 1),
                                        progressColor: ColorSchemes.primary,
                                        animation: true,
                                        lineHeight: 8,
                                        barRadius: const Radius.circular(12),
                                        isRTL: Directionality.of(context) ==
                                                TextDirection.rtl
                                            ? true
                                            : false,
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ))
                              .toList(),
                          Row(
                            children: [
                              SvgPicture.asset(
                                ImagePaths.surveyCount,
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                S.of(context).totalNumbersOfUsers,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorSchemes.gray,
                                      letterSpacing: -0.24,
                                    ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "(${widget.survey.countQuestionAnswers})",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _defaultSize() {
    return const SizedBox(height: 13);
  }
}
