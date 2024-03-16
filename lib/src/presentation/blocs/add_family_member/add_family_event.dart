part of 'add_family_bloc.dart';

abstract class AddFamilyEvent extends Equatable {
  const AddFamilyEvent();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class InitializeAddFamilyMemberEvent extends AddFamilyEvent {
  final FamilyMember? familyMember;
  final List<FamilyMemberType> familyMembersTypes;

  const InitializeAddFamilyMemberEvent({
    this.familyMember,
    required this.familyMembersTypes,
  });
}

class SelectFamilyRelationEvent extends AddFamilyEvent {
  final List<FamilyMemberType> familyMemberTypes;
  final FamilyMemberType selectedFamilyMemberType;

  const SelectFamilyRelationEvent({
    required this.familyMemberTypes,
    required this.selectedFamilyMemberType,
  });
}

class ValidateNameEvent extends AddFamilyEvent {
  final String name;

  const ValidateNameEvent({
    required this.name,
  });
}

class ValidateMobileNumberEvent extends AddFamilyEvent {
  final String mobileNumber;
  final String regionCode;

  const ValidateMobileNumberEvent({
    required this.mobileNumber,
    required this.regionCode,
  });
}

class ValidateFamilyMemberFormEvent extends AddFamilyEvent {
  final String name;
  final String mobileNumber;
  final String countryCode;
  final List<FamilyMemberType> familyMemberTypes;
  final String emailAddress;
  final String imagePath;

  const ValidateFamilyMemberFormEvent({
    required this.name,
    required this.mobileNumber,
    required this.countryCode,
    required this.familyMemberTypes,
    required this.emailAddress,
    required this.imagePath,
  });
}

class AddFamilyMemberEvent extends AddFamilyEvent {
  // final FamilyMember familyMember;
  final AddUserFamilyMemberRequest request;
  final String imagePath;

  const AddFamilyMemberEvent({
    // required this.familyMember,
    required this.request,
    required this.imagePath,
  });
}
class UpdateFamilyMemberEvent extends AddFamilyEvent {
  // final FamilyMember familyMember;
  final UpdateUserFamilyMemberRequest request;
  final String imagePath;

  const UpdateFamilyMemberEvent({
    // required this.familyMember,
    required this.request,
    required this.imagePath,
  });
}

class NavigateBackEvent extends AddFamilyEvent {
  final Map<String,dynamic>? arguments;

  const NavigateBackEvent({
    this.arguments,
  });
}

class ValidateEmailAddressEvent extends AddFamilyEvent {
  final String emailAddress;

  const ValidateEmailAddressEvent({
    required this.emailAddress,
  });
}

class ValidateImageSelectionEvent extends AddFamilyEvent {
  final String imagePath;

  const ValidateImageSelectionEvent({
    required this.imagePath,
  });
}
