// ignore_for_file: must_be_immutable

part of 'add_family_bloc.dart';

abstract class AddFamilyState extends Equatable {
  const AddFamilyState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class AddFamilyMemberInitial extends AddFamilyState {}

class ShowLoadingState extends AddFamilyState {}

class HideLoadingState extends AddFamilyState {}

class InitializeAddFamilyMemberState extends AddFamilyState {
  final FamilyMember? familyMember;
  final List<FamilyMemberType> familyMemberTypes;

  const InitializeAddFamilyMemberState({
    this.familyMember,
    required this.familyMemberTypes,
  });
}

class SelectFamilyRelationState extends AddFamilyState {
  final List<FamilyMemberType> familyMemberTypes;

  const SelectFamilyRelationState({
    required this.familyMemberTypes,
  });
}

class NameValidState extends AddFamilyState {}

class NameInvalidState extends AddFamilyState {
  final String errorMessage;

  const NameInvalidState({required this.errorMessage});
}

class MobileNumberValidState extends AddFamilyState {
  final String countryCode;

  const MobileNumberValidState({
    required this.countryCode,
  });
}

class MobileNumberInvalidState extends AddFamilyState {
  final String errorMessage;

  const MobileNumberInvalidState({required this.errorMessage});
}


class FamilyMemberTypeValidState extends AddFamilyState {}

class FamilyMemberTypeInvalidState extends AddFamilyState {
  final String errorMessage;

  const FamilyMemberTypeInvalidState({required this.errorMessage});
}

class ValidAddFamilyFormState extends AddFamilyState {
  final String name;
  final String mobileNumber;
  final int familyMemberTypeId;
  final String email;
  final String attachment;
  final String countryCode;

  const ValidAddFamilyFormState({
    required this.name,
    required this.mobileNumber,
    required this.familyMemberTypeId,
    required this.email,
    required this.attachment,
    required this.countryCode,
  });
}


class AddFamilyMemberSuccessState extends AddFamilyState {
  List<FamilyMember> familyMembersList;
  Invitation invitation;
  final String message;
  AddFamilyMemberSuccessState({
    required this.familyMembersList,
    required this.invitation,
    required this.message,
  });
}

class AddFamilyMemberErrorState extends AddFamilyState {
  final String message;

  const AddFamilyMemberErrorState({
    required this.message,
  });
}

class UpdateFamilyMemberSuccessState extends AddFamilyState {
  List<FamilyMember> familyMembersList;
  final String message;
  UpdateFamilyMemberSuccessState({
    required this.familyMembersList,
    required this.message,
  });
}

class UpdateFamilyMemberErrorState extends AddFamilyState {
  final String message;

  const UpdateFamilyMemberErrorState({
    required this.message,
  });
}

class NavigateBackState extends AddFamilyState {
  final Map<String,dynamic>? arguments;

  const NavigateBackState({
    required this.arguments,
  });
}

class EmailValidState extends AddFamilyState {}

class EmailInvalidState extends AddFamilyState {
  final String errorMessage;

  const EmailInvalidState({required this.errorMessage});
}

class ImageSelectionValidState extends AddFamilyState {
  final String imagePath;

  const ImageSelectionValidState({required this.imagePath});
}

class ImageSelectionInvalidState extends AddFamilyState {
  final String errorMessage;

  const ImageSelectionInvalidState({required this.errorMessage});
}

class ScrollToItemState extends AddFamilyState {}