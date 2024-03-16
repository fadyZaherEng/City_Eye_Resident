import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/rating_botom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future openRatingBottomSheetWidget({
  required BuildContext context,
  required void Function(
    double rating,
    String reviewValue,
  ) onSendAction,
  required double ratingValue,
  double height = 400,
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
            height: height,
            content: RatingBottomSheetWidget(
              onSendAction: onSendAction,
              rate: ratingValue,
            ),
            titleLabel: '',
          )));
}
