import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/car_configuration.dart';
import 'package:city_eye/src/presentation/screens/profile/add_car_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showAddCarBottomSheetWidget({
  required BuildContext context,
  required double height,
  required CarConfiguration carConfiguration,
  required Function(List<Car>) onTapAdd,
  required Function(List<Car>) onTapUpdate,
  Car? car,
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
        titleLabel:
            car == null ? S.of(context).addNewCar : S.of(context).updateCar,
        height: height,
        content: AddCarWidget(
          carConfiguration: carConfiguration,
          onTapAdd: onTapAdd,
          onTapUpdate:onTapUpdate,
          car: car,
        ),
      ),
    ),
  ).then(
    (value) {
      if (value != null) {}
    },
  );
}
