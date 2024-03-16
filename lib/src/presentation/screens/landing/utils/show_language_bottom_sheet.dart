import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/language_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showLanguageBottomSheet({
  required BuildContext context,
  required double height,
  required List<Language> languages,
  required Language selectedLanguage,
  required Function(Language) onLanguageSelected,
}) async {
  double getHeight(List<Language> languages, BuildContext context) {
    double height = 85;
    for (int i = 0; i < languages.length; i++) {
      height += 60;
    }

    if (height < MediaQuery.of(context).size.height * 0.7) {
      return height;
    }
    return MediaQuery.of(context).size.height * 0.7;
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
        titleLabel: S.of(context).selectLanguage,
        height: getHeight(languages, context),
        content: LanguageBottomSheetWidget(
            languages: languages,
            selectedLanguage: selectedLanguage,
            onLanguageSelected: onLanguageSelected,
            scrollPhysics:
                getLanguageScrollPhysics(getHeight(languages, context))),
      ),
    ),
  );
}
