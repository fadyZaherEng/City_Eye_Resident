import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:city_eye/src/presentation/screens/profile/add_family_member_widget.dart';
import 'package:city_eye/src/presentation/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

Future showAddNewFamilyMemberBottomSheetWidget({
  required BuildContext context,
  required double height,
  bool isUpdate = false,
  FamilyMember? familyMember,
  required List<FamilyMemberType> familyMembersTypes,
  required Function(List<FamilyMember>) isUpdateFamilyMemberList,
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
        familyMember == null ? S.of(context).addNewMember : S.of(context).updateFamilyMember,
        height: height,
        content: AddFamilyMemberWidget(
          familyMember: familyMember,
          familyMembersTypes: familyMembersTypes,
          isUpdate: isUpdate,
          isUpdateFamilyMemberList: isUpdateFamilyMemberList,
        ),
      ),
    ),
  ).then(
    (value) {
      if (value != null) {}
    },
  );
}
