import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:city_eye/src/presentation/screens/contact_us/widgets/country_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showCountryBottomSheet({
  required BuildContext context,
  required double height,
  required List<Country> countries,
  required Country selectedCountry,
  required Function(Country) onCountrySelected,
}) async {
  double getHeight(List<Country> searchable, BuildContext context) {
    double height = 115;
    for (int i = 0; i < searchable.length; i++) {
      height += 60;
    }

    if (height < MediaQuery.of(context).size.height * 0.7) {
      return height + 70;
    }
    return (MediaQuery.of(context).size.height * 0.7) + 70;
  }

  ScrollPhysics? getBottomSheetScrollPhysics(double height) {
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
        titleLabel: S.of(context).selectCountry,
        height: getHeight(countries, context),
        content: CountryBottomSheetWidget(
            countries: countries,
            selectedCountry: selectedCountry,
            onCountrySelected: onCountrySelected,
            scrollPhysics:
                getBottomSheetScrollPhysics(getHeight(countries, context))),
      ),
    ),
  );
}
