import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/invitation.dart';
import 'package:equatable/equatable.dart';

class FamilyMemberInvitation extends Equatable {
  final Invitation invitation;
  final List<FamilyMember> familyMembers;

  const FamilyMemberInvitation({
    this.invitation = const Invitation(),
    this.familyMembers = const [],
  });

  @override
  List<Object?> get props => [invitation, familyMembers];
}
