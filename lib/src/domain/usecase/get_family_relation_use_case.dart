import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';

class GetFamilyRelationUseCase {
  List<FamilyMemberType> call(FamilyMember? familyMember, List<FamilyMemberType> familyMemberTypes) {
    if(familyMember == null) {
      return familyMemberTypes;
    }
    for(var index = 0; index < familyMemberTypes.length; index++) {
      var familyMemberType = familyMemberTypes[index];
      if(familyMemberType.id == familyMember.familyMemberType.id) {
        familyMemberTypes[index] = familyMemberType.copyWith(
          isSelected: true,
        );
        break;
      }
    }
    return familyMemberTypes;
  }
}