import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/dynamic_questions_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future openDynamicQuestionsBottomSheet({
  required BuildContext context,
  required double height,
  required List<PageField> questions,
  required Function(List<PageField>) onOkPresses,
}) async {
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        titleLabel: "",
        height: _getHeight(questions, context) ,
        isTitleVisible: false,
        content: DynamicQuestionsBottomSheetWidget(
          questions: questions,
          onOkPressed: onOkPresses,
        ),
      ),
    ),
  );
}

double _getHeight(List<PageField> questions,BuildContext context) {
  double height = 150;
  for (var element in questions) {
    if(element.code == QuestionsCode.image) {
      height += 250;
    } else {
      height += 120;
    }
  }
  if(height < MediaQuery.of(context).size.height * 0.7) {
    return height;
  }
  return MediaQuery.of(context).size.height * 0.7;
}
