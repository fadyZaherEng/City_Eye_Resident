import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';

class SelectFamilyRelationUseCase {
  List<FamilyMemberType> call(List<FamilyMemberType> familyMemberTypes,FamilyMemberType selectedFamilyMemberType) {
    for(var index = 0; index < familyMemberTypes.length; index++) {
      if(familyMemberTypes[index].id == selectedFamilyMemberType.id) {
        familyMemberTypes[index] = familyMemberTypes[index].copyWith(
          isSelected: !familyMemberTypes[index].isSelected,
        );
      } else {
        familyMemberTypes[index] = familyMemberTypes[index].copyWith(
          isSelected: false,
        );
      }
    }
    return familyMemberTypes;
  }
}