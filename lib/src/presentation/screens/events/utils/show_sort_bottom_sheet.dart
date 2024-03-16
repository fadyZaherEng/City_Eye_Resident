import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/gallery/sort.dart';
import 'package:city_eye/src/presentation/screens/events/widgets/sort_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showSortsBottomSheet({
  required BuildContext context,
  required double height,
  required List<Sort> sorts,
  required Sort selectedSort,
  required Function(Sort) onSortSelected,
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
        titleLabel: S.of(context).sort,
        height: height,
        content: SortBottomSheetWidget(
          sorts: sorts,
          selectedSort: selectedSort,
          onSortSelected: onSortSelected,
        ),
      ),
    ),
  );
}
