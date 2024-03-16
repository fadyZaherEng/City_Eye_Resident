import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/rating_botom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future openRatingBottomSheetWidget({
  required BuildContext context,
  required void Function(
    double rating,
    String review,
  ) onSendAction,
  required double rate,
  String comment = '',
  bool isRated = false,
  double height = 410 ,
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
            height: height  < MediaQuery.of(context).size.height * 0.7 ? (isRated ? 350 : height) : MediaQuery.of(context).size.height * 0.7,
            content: RatingBottomSheetWidget(
              onSendAction: onSendAction,
              rate: rate,
              comment: comment,
              isRated: isRated,
            ),
            titleLabel: '',
            isTitleImage: true,
            imageWidget: SvgPicture.asset(
              ImagePaths.rating,
              fit: BoxFit.scaleDown,
              matchTextDirection: true,
            ),
          )));
}
