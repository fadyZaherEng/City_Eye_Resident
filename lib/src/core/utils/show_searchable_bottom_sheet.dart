import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/searchable_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showSearchableBottomSheet({
  required BuildContext context,
  required PageField pageField,
  Function(PageField, Choice)? onChoicesSelected,
  Function(PageField, List<Choice>)? onSaveMultiChoice,
  required bool isMultiChoice,
}) async {
  double getHeight(List<Choice> searchable, BuildContext context) {
    double height = 100;
    for (int i = 0; i < searchable.length; i++) {
      height += 60;
    }

    if (height < MediaQuery.of(context).size.height * 0.7) {
      return isMultiChoice ? height + 150 : height + 70;
    }
    return isMultiChoice
        ? (MediaQuery.of(context).size.height * 0.7) + 150
        : (MediaQuery.of(context).size.height * 0.7) + 70;
  }

  ScrollPhysics? getLanguageScrollPhysics(double height) {
    if (height < MediaQuery.of(context).size.height * 0.7) {
      return const NeverScrollableScrollPhysics();
    }
    return null;
  }

  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomSheetWidget(
        titleLabel: pageField.description,
        height: getHeight(pageField.choices, context),
        content: SearchableBottomSheetWidget(
          pageField: pageField,
          onChoicesSelected: (pageField, choice) {
            onChoicesSelected!(pageField, choice);
          },
          scrollPhysics:
              getLanguageScrollPhysics(getHeight(pageField.choices, context)),
          onSaveMultiChoice: (pageField, multiChoiceValue) {
            onSaveMultiChoice!(pageField, multiChoiceValue);
          },
          isMultiChoice: isMultiChoice,
        ),
      ),
    ),
  );
}
