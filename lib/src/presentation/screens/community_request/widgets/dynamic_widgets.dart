import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/date_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/extra_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/multi_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/numaric_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/searchable_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/signle_selection_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/extra_fields/upload_image_field_widget.dart';
import 'package:flutter/material.dart';

class DynamicWidgets extends StatefulWidget {
  final List<PageField> question;
  final void Function(PageField question, int answerId) onTapSingleSelection;
  final void Function(PageField question, int answerId) onTapMultiSelection;
  final void Function(PageField question) onTapDateDeleteAnswer;
  final void Function(PageField question, String answer) onTapPickDateAnswer;
  final void Function(PageField question, String answer)
      onTapTextAnswerQuestion;
  final void Function(PageField question, String answer)
      onTapNumericAnswerQuestion;
  final void Function(
    PageField question,
  ) onShowUploadImageBottomSheet;
  final void Function(
    PageField question,
  ) onShowDialogToDeleteImage;
  final Function(PageField, bool) onOpenSearchableBottomSheet;

  const DynamicWidgets({
    super.key,
    required this.onTapSingleSelection,
    required this.onTapMultiSelection,
    required this.onTapDateDeleteAnswer,
    required this.onTapPickDateAnswer,
    required this.onTapTextAnswerQuestion,
    required this.onTapNumericAnswerQuestion,
    required this.onShowUploadImageBottomSheet,
    required this.onShowDialogToDeleteImage,
    required this.question,
    required this.onOpenSearchableBottomSheet,
  });

  @override
  State<DynamicWidgets> createState() => _DynamicWidgetsState();
}

class _DynamicWidgetsState extends State<DynamicWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right:16, bottom: 16),
      child: Column(children: _createDynamicListWidgets(context)),
    );
  }

  List<Widget> _createDynamicListWidgets(BuildContext context) {
    List<Widget> list = [];
    for (var question in widget.question) {
      if (question.code == QuestionsCode.singleChoice) {
        list.add(SingleSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          selectAnswer: (answerId) {
            widget.onTapSingleSelection(question, answerId);
          },
          showSeparator: !(question == widget.question.last),
        ));
      } else if (question.code == QuestionsCode.multiChoice) {
        list.add(MultiSelectionFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          selectAnswer: (answerId) {
            widget.onTapMultiSelection(question, answerId);
          },
          showSeparator: !(question == widget.question.last),
        ));
      } else if (question.code == QuestionsCode.date) {
        list.add(DateTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          deleteDate: () {
            widget.onTapDateDeleteAnswer(question);
          },
          pickDate: (answer) {
            widget.onTapPickDateAnswer(question, answer);
          },
          showSeparator: !(question == widget.question.last),
        ));
      } else if (question.code == QuestionsCode.text) {
        list.add(ExtraTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          updateAnswer: false,
          addAnswer: (answer) {
            widget.onTapTextAnswerQuestion(question, answer);
          },
          showSeparator: !(question == widget.question.last),
        ));
      } else if (question.code == QuestionsCode.number) {
        list.add(NumericTextFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          updateAnswer: false,
          addAnswer: (answer) {
            widget.onTapNumericAnswerQuestion(question, answer);
          },
          showSeparator: !(question == widget.question.last),
        ));
      } else if (question.code == QuestionsCode.image) {
        list.add(UploadImageFieldWidget(
          horizontalPadding: 0,
          verticalPadding: 16,
          pageField: question,
          showUploadImageBottomSheet: () {
            widget.onShowUploadImageBottomSheet(question);
          },
          showDialogToDeleteImage: () {
            widget.onShowDialogToDeleteImage(question);
          },
          showSeparator: !(question == widget.question.last),
        ));
      } else if (question.code == QuestionsCode.searchableSingle ||
          question.code == QuestionsCode.searchableMulti) {
        list.add(SearchableFieldWidget(
          pageField: question,
          horizontalPadding: 0,
          verticalPadding: 16,
          showSeparator: false,
          openBottomSheet: () {
            widget.onOpenSearchableBottomSheet(
                question, question.code == QuestionsCode.searchableMulti);
          },
        ));
      }
    }
    return list;
  }
}
