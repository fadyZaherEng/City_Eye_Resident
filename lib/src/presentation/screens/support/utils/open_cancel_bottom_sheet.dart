import 'package:city_eye/src/presentation/screens/support/widgets/cancel_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future openCancelBottomSheet({
  required BuildContext context,
  double height = 340,
  required Function(String) onSend,
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
        isTitleImage: true,
        height: height < MediaQuery.of(context).size.height * 0.7 ? height : MediaQuery.of(context).size.height * 0.7,
        content: CancelBottomSheetWidget(
          onSend: onSend,
        ),
      ),
    ),
  );
}
