import 'dart:ffi';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/qr/day.dart';
import 'package:city_eye/src/domain/entities/qr/day_time.dart';
import 'package:city_eye/src/domain/entities/qr/guests_type.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qrs_type.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/screens/qr/qr_screen.dart';
import 'package:city_eye/src/presentation/screens/qr/skeleton/create_qr_skeleton_widget.dart';
import 'package:city_eye/src/presentation/screens/qr/widgets/multi_selection_item.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_with_suffix_icon_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/date_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/extra_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/multi_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/numaric_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/searchable_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/signle_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/upload_image_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateQRScreen extends BaseStatefulWidget {
  final ScrollController scrollController;
  final TextEditingController selectDateController;
  final TextEditingController visitorNameController;
  final QrConfiguration qrConfiguration;
  final GuestsType guestsType;
  final QrsType qrsType;
  final bool showSkeleton;
  final List<PageField> questions;
  final DateTime? selectedDate;
  final Function(GuestsType) selectGuestType;
  final Function(QrsType) selectQrsType;
  final Function(List<PageField>, PageField, int) selectSingleAnswer;
  final Function(List<PageField>, PageField, int) selectMultipleAnswer;
  final Function(List<PageField>, PageField, dynamic) answerQuestion;
  final Function(List<PageField>, PageField) deleteAnswer;
  final Function(List<PageField>, PageField) selectImage;
  final Function(List<PageField>, PageField) deleteImage;
  final Function(List<PageField>, PageField) openSearchableQuestion;
  final Function() openRulesBottomSheet;
  final Function(List<PageField>) onCreateQR;
  final Function() onSelectDate;
  final Function() onDeleteDate;
  final QrErrorMessages qrErrorMessages;
  final Function() onValidateVisitorName;
  final List<DayTime> singleQrAvailableTimes;
  final Function(List<DayTime>, DayTime) onSelectSingleQrTime;
  final List<Day> multipleQrAvailableDays;
  final List<Day> multipleQrOrderedSelectedDays;
  final Function(List<Day>, Day) onSelectMultipleQrDays;
  final Function(List<Day>, Day, DayTime) onSelectMultipleQrTime;

  const CreateQRScreen({
    Key? key,
    required this.scrollController,
    required this.selectDateController,
    required this.visitorNameController,
    required this.qrConfiguration,
    required this.guestsType,
    required this.qrsType,
    required this.selectedDate,
    required this.onDeleteDate,
    required this.questions,
    required this.showSkeleton,
    required this.selectGuestType,
    required this.selectQrsType,
    required this.selectSingleAnswer,
    required this.selectMultipleAnswer,
    required this.answerQuestion,
    required this.deleteAnswer,
    required this.selectImage,
    required this.deleteImage,
    required this.openSearchableQuestion,
    required this.openRulesBottomSheet,
    required this.onCreateQR,
    required this.onSelectDate,
    required this.qrErrorMessages,
    required this.onValidateVisitorName,
    required this.singleQrAvailableTimes,
    required this.onSelectSingleQrTime,
    required this.multipleQrAvailableDays,
    required this.onSelectMultipleQrDays,
    required this.multipleQrOrderedSelectedDays,
    required this.onSelectMultipleQrTime,
  }) : super(key: key);

  @override
  BaseState<CreateQRScreen> baseCreateState() => _CreateeQRScreenState();
}

class _CreateeQRScreenState extends BaseState<CreateQRScreen> {
  @override
  Widget baseBuild(BuildContext context) {
    return widget.showSkeleton
        ? const CreateQrSkeletonWidget()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      _buildGuestTypeSection(),
                      const SizedBox(height: 12.0),
                      _buildDivider(),
                      const SizedBox(height: 16.0),
                      _buildQrTypesSection(),
                      const SizedBox(height: 12.0),
                      _buildDivider(),
                      const SizedBox(height: 8.0),
                      _buildSelectDateSection(),
                      const SizedBox(height: 8.0),
                      _buildSelectDaysSection(),
                      _buildSelectTimesSection(),
                      const SizedBox(height: 8.0),
                      _buildDivider(),
                      const SizedBox(height: 16.0),
                      _buildVisitorNameSection(),
                      const SizedBox(height: 16.0),
                      if (widget.questions.isNotEmpty) _buildDivider(),
                      ..._buildGuestTypeQuestions(widget.questions),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: widget.guestsType.rules.isNotEmpty,
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagePaths.rules),
                            const SizedBox(width: 4),
                            Text(
                              "${S.of(context).youApproveOn} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: ColorSchemes.black,
                                      letterSpacing: -0.24),
                            ),
                            GestureDetector(
                              onTap: widget.openRulesBottomSheet,
                              child: Text(S.of(context).rules,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: ColorSchemes.primary,
                                          letterSpacing: -0.24,
                                          decoration:
                                              TextDecoration.underline)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomButtonWidget(
                        onTap: () {
                          widget.onCreateQR(widget.questions);
                        },
                        text: S.of(context).create,
                        width: double.infinity,
                        backgroundColor: F.isNiceTouch
                            ? ColorSchemes.ghadeerDarkBlue
                            : ColorSchemes.primary,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                )
              ],
            ));
  }

  Widget _buildGuestTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).guestType,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorSchemes.black,
              ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: widget.qrConfiguration.guestsTypes.length,
            itemBuilder: (context, index) {
              return CustomButtonBorderWidget(
                onTap: () {
                  widget.selectGuestType(
                    widget.qrConfiguration.guestsTypes[index],
                  );
                },
                buttonTitle: widget.qrConfiguration.guestsTypes[index].name,
                isSelected: widget.qrConfiguration.guestsTypes[index].id ==
                    widget.guestsType.id,
              );
            },
          ),
        ),
        Visibility(
          visible: false,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                S.of(context).thisFieldIsRequired,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorSchemes.redError,
                      letterSpacing: -.24,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQrTypesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).typeYourQrCode,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorSchemes.black),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: widget.guestsType.qrTypes.length,
            itemBuilder: (context, index) {
              return CustomButtonBorderWidget(
                onTap: () {
                  widget.selectQrsType(
                    widget.guestsType.qrTypes[index],
                  );
                },
                buttonTitle: widget.guestsType.qrTypes[index].name,
                isSelected:
                    widget.guestsType.qrTypes[index].id == widget.qrsType.id,
              );
            },
          ),
        ),
        Visibility(
          visible: false,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                S.of(context).thisFieldIsRequired,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorSchemes.redError,
                      letterSpacing: -.24,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectDateSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key: widget.qrErrorMessages.dateKey,
            widget.qrsType.code == "single"
                ? S.of(context).selectDate
                : S.of(context).qrExpireDate,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: ColorSchemes.black),
          ),
          const SizedBox(height: 16.0),
          CustomTextFieldWithSuffixIconWidget(
            controller: widget.selectDateController,
            labelTitle: widget.qrsType.code == "single"
                ? S.of(context).selectDate
                : S.of(context).qrExpireDate,
            onTap: () {
              widget.onSelectDate();
            },
            suffixIcon:
                widget.selectDateController.text.trim().toString().isEmpty
                    ? SvgPicture.asset(
                        ImagePaths.selectDate,
                        fit: BoxFit.scaleDown,
                        matchTextDirection: true,
                      )
                    : InkWell(
                        onTap: () {
                          widget.onDeleteDate();
                        },
                        child: SvgPicture.asset(
                          ImagePaths.close,
                          fit: BoxFit.scaleDown,
                          matchTextDirection: true,
                        ),
                      ),
            isReadOnly: true,
            errorMessage: widget.qrErrorMessages.dateErrorMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDaysSection() {
    return Visibility(
      visible: widget.qrsType.code != "single" &&
          widget.multipleQrAvailableDays.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDivider(),
            const SizedBox(height: 8.0),
            Text(
              key: widget.qrErrorMessages.daysKey,
              S.of(context).selectDay,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: widget.multipleQrAvailableDays.length,
                itemBuilder: (context, index) {
                  return MultiSelectionItem(
                    onTap: () {
                      widget.onSelectMultipleQrDays(
                        widget.multipleQrAvailableDays,
                        widget.multipleQrAvailableDays[index],
                      );
                    },
                    text: _getSelectedTime(widget.multipleQrOrderedSelectedDays,
                                widget.multipleQrAvailableDays[index])
                            .isNotEmpty
                        ? "${widget.multipleQrAvailableDays[index].name}\n \u200E${_getSelectedTime(widget.multipleQrOrderedSelectedDays, widget.multipleQrAvailableDays[index])}"
                        : widget.multipleQrAvailableDays[index].name,
                    isSelected:
                        widget.multipleQrAvailableDays[index].isSelected,
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            widget.qrErrorMessages.daysErrorMessage != null
                ? Text(
                    S.of(context).thisFieldIsRequired,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.redError,
                          letterSpacing: -.24,
                        ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _buildQrSingleTimesSection() {
    return Visibility(
      visible: widget.selectedDate != null &&
          widget.singleQrAvailableTimes.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDivider(),
            const SizedBox(height: 8.0),
            Text(
              key: widget.qrErrorMessages.timeKey,
              S.of(context).selectTime,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 35,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: widget.singleQrAvailableTimes.length,
                itemBuilder: (context, index) {
                  return CustomButtonBorderWidget(
                    onTap: () {
                      widget.onSelectSingleQrTime(
                        widget.singleQrAvailableTimes,
                        widget.singleQrAvailableTimes[index],
                      );
                    },
                    buttonTitle:
                        "\u200E${widget.singleQrAvailableTimes[index].time}",
                    isSelected: widget.singleQrAvailableTimes[index].isSelected,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            widget.qrErrorMessages.timeErrorMessage != null
                ? Text(
                    S.of(context).thisFieldIsRequired,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.redError,
                          letterSpacing: -.24,
                        ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _buildQrMultipleTimesSection() {
    if (widget.multipleQrOrderedSelectedDays.isEmpty) return SizedBox.shrink();
    return Visibility(
      visible: widget.selectedDate != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDivider(),
            const SizedBox(height: 8.0),
            Text(
              key: widget.qrErrorMessages.timeKey,
              S.of(context).selectTime,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: ColorSchemes.black),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 35,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount:
                    widget.multipleQrOrderedSelectedDays.last.times.length,
                itemBuilder: (context, index) {
                  return CustomButtonBorderWidget(
                    onTap: () {
                      widget.onSelectMultipleQrTime(
                        widget.multipleQrOrderedSelectedDays,
                        widget.multipleQrOrderedSelectedDays.last,
                        widget.multipleQrOrderedSelectedDays.last.times[index],
                      );
                    },
                    buttonTitle:
                        "\u200E${widget.multipleQrOrderedSelectedDays.last.times[index].time}",
                    isSelected: widget.multipleQrOrderedSelectedDays.last
                        .times[index].isSelected,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            widget.qrErrorMessages.timeErrorMessage != null
                ? Text(
                    S.of(context).thisFieldIsRequired,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: ColorSchemes.redError,
                          letterSpacing: -.24,
                        ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  String _getSelectedTime(
    List<Day> days,
    Day selectedDay,
  ) {
    for (var day in days) {
      if (day.id == selectedDay.id) {
        for (var time in day.times) {
          if (time.isSelected) {
            return time.time;
          }
        }
      }
    }
    return "";
  }

  Widget _buildSelectTimesSection() {
    return widget.qrsType.code == "single"
        ? _buildQrSingleTimesSection()
        : _buildQrMultipleTimesSection();
  }

  Widget _buildVisitorNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key: widget.qrErrorMessages.visitorKey,
          S.of(context).typeYourName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: ColorSchemes.black),
        ),
        const SizedBox(height: 16.0),
        CustomTextFieldWidget(
          controller: widget.visitorNameController,
          labelTitle: S.of(context).typeYourName,
          onChange: (string) {
            widget.onValidateVisitorName();
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(
              RegExp(
                r'[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{2600}-\u{26FF}\u{2700}-\u{27BF}]',
                unicode: true,
              ),
            ),
            FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
            FilteringTextInputFormatter.deny(RegExp(r' \s'),
                replacementString: " "),
          ],
          errorMessage: widget.qrErrorMessages.visitorNameErrorMessage,
          textInputType: TextInputType.name,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      color: ColorSchemes.gray,
    );
  }

  List<Widget> _buildGuestTypeQuestions(List<PageField> questions) {
    List<Widget> questionWidgets = [];

    for (var question in questions) {
      if (question.code == QuestionsCode.singleChoice) {
        questionWidgets.add(SingleSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          showSeparator: !(question == questions.last),
          selectAnswer: (answerId) {
            widget.selectSingleAnswer(questions, question, answerId);
          },
        ));
      } else if (question.code == QuestionsCode.multiChoice) {
        questionWidgets.add(MultiSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          showSeparator: !(question == questions.last),
          selectAnswer: (answerId) {
            widget.selectMultipleAnswer(questions, question, answerId);
          },
        ));
      } else if (question.code == QuestionsCode.date) {
        questionWidgets.add(DateTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          showSeparator: !(question == questions.last),
          deleteDate: () {
            widget.deleteAnswer(questions, question);
          },
          pickDate: (answer) {
            widget.answerQuestion(questions, question, answer);
          },
        ));
      } else if (question.code == QuestionsCode.text) {
        questionWidgets.add(ExtraTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          updateAnswer: false,
          showSeparator: !(question == questions.last),
          addAnswer: (answer) {
            widget.answerQuestion(questions, question, answer);
          },
        ));
      } else if (question.code == QuestionsCode.number) {
        questionWidgets.add(NumericTextFieldWidget(
            horizontalPadding: 0,
            verticalPadding: 16,
            pageField: question,
            updateAnswer: true,
            showSeparator: !(question == questions.last),
            addAnswer: (answer) {
              widget.answerQuestion(questions, question, answer);
            }));
      } else if (question.code == QuestionsCode.image) {
        questionWidgets.add(UploadImageFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          showSeparator: !(question == questions.last),
          showUploadImageBottomSheet: () {
            widget.selectImage(questions, question);
          },
          showDialogToDeleteImage: () {
            widget.deleteImage(questions, question);
          },
        ));
      } else if (question.code == QuestionsCode.searchableSingle ||
          question.code == QuestionsCode.searchableMulti) {
        questionWidgets.add(SearchableFieldWidget(
          pageField: question,
          horizontalPadding: 0,
          verticalPadding: 16,
          showSeparator: !(question == questions.last),
          openBottomSheet: () {
            widget.openSearchableQuestion(questions, question);
          },
        ));
      }
    }

    return questionWidgets;
  }
}
