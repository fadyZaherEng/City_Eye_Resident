import 'dart:async';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/lookup_keys.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/validation/profile_info_validator.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/delete_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_info_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_unit_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/car_configuration.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';
import 'package:city_eye/src/domain/entities/profile/profile.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:city_eye/src/domain/entities/profile/profile_image.dart';
import 'package:city_eye/src/domain/entities/profile/profile_unit.dart';
import 'package:city_eye/src/domain/entities/settings/choice.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/usecase/delete_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/delete_user_family_member_use_case.dart';
import 'package:city_eye/src/domain/usecase/dynamic_question_validation_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/profile_info_form_validation_use_case.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/usecase/delete_user_unit_car_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_lookup_data_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_profile_use_case.dart';
import 'package:city_eye/src/domain/usecase/save_user_information_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_documents_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_image_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_info_use_case.dart';
import 'package:city_eye/src/domain/usecase/update_user_unit_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetLookupDataUseCase _getLookupDataUseCase;
  final DeleteCarUseCase _deleteCarUseCase;
  final ProfileInfoFormValidationUseCase _profileInfoFormValidationUseCase;
  final DeleteUserFamilyMemberUseCase _deleteUserFamilyMemberUseCase;
  final UpdateUserUnitUseCase _updateUserUnitUseCase;
  final DeleteUserUnitCarUseCase _deleteUserUnitCarUseCase;
  final UpdateUserDocumentsUseCase _updateUserDocumentsUseCase;
  final UpdateUserInfoUseCase _updateUserInfoUseCase;
  final UpdateUserImageUseCase _updateUserImageUseCase;
  final GetUserInformationUseCase _getUserInformationUseCase;
  final SaveUserInformationUseCase _saveUserInformationUseCase;
  final DynamicQuestionValidationUseCase _dynamicQuestionValidationUseCase;

  ProfileBloc(
    this._getUserProfileUseCase,
    this._getLookupDataUseCase,
    this._deleteCarUseCase,
    this._profileInfoFormValidationUseCase,
    this._deleteUserFamilyMemberUseCase,
    this._updateUserUnitUseCase,
    this._deleteUserUnitCarUseCase,
    this._updateUserDocumentsUseCase,
    this._updateUserInfoUseCase,
    this._updateUserImageUseCase,
    this._getUserInformationUseCase,
    this._saveUserInformationUseCase,
    this._dynamicQuestionValidationUseCase,
  ) : super(ProfileInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfileEvent);
    on<StepPressedEvent>(_onStepPressedEvent);
    on<UploadProfileImagePressedEvent>(_onUploadProfileImagePressedEvent);
    on<AskForCameraPermissionEvent>(_onAskForCameraPermissionEvent);
    on<CameraPressedEvent>(_onCameraPressedEvent);
    on<GalleryPressedEvent>(_onGalleryPressedEvent);
    on<SelectImageEvent>(_onSelectImageEvent);
    on<AddPressedEvent>(_onAddPressedEvent);
    on<DeleteFamilyMemberEvent>(_onDeleteFamilyMemberEvent);
    on<DeleteCarEvent>(_onDeleteCarEvent);
    on<UploadFileImageEvent>(_onUploadFileImageEvent);
    on<UploadFileDocumentEvent>(_onUploadFileDocumentEvent);
    on<SelectFileExpireDateEvent>(_onSelectFileExpireDateEvent);
    on<SelectFileImageEvent>(_onSelectFileImageEvent);
    on<NavigateBackEvent>(_onNavigateBackEvent);
    on<DeleteFileImageEvent>(_onDeleteFileImageEvent);
    on<DeleteFileDocumentEvent>(_onDeleteFileDocumentEvent);
    on<SelectFileDocumentEvent>(_onSelectFileDocumentEvent);
    on<AskForStoragePermissionEvent>(_onAskForStoragePermissionEvent);
    on<SaveFilesPressedEvent>(_onSaveFilesPressedEvent);
    on<ValidateGasNumberEvent>(_onValidateGasNumberEvent);
    on<ValidateTelephoneEvent>(_onValidateTelephoneEvent);
    on<UnitSaveButtonPressedEvent>(_onUnitSaveButtonPressedEvent);
    on<UpdateProfileUnitEvent>(_onUpdateProfileUnitEvent);
    on<SelectProfileUnitUserTypeEvent>(_onSelectProfileUnitUserTypeEvent);
    on<ValidateInfoNameEvent>(_onValidateInfoNameEvent);
    on<ValidateInfoEmailEvent>(_onValidateInfoEmailEvent);
    on<SelectSingleSelectionAnswerEvent>(_onSelectSingleSelectionAnswerEvent);
    on<SelectMultiSelectionAnswerEvent>(_onSelectMultiSelectionAnswerEvent);
    on<DeleteQuestionAnswerEvent>(_onDeleteQuestionAnswerEvent);
    on<AddAnswerToQuestionEvent>(_onAddAnswerToQuestionEvent);
    on<SelectQuestionImageEvent>(_onSelectQuestionImageEvent);
    on<UploadProfileInfoImage>(_onUploadProfileInfoImage);
    on<DeleteQuestionImageEvent>(_onDeleteQuestionImageEvent);
    on<InfoSaveButtonPressedEvent>(_onInfoSaveButtonPressedEvent);
    on<UpdateProfileInfoEvent>(_onUpdateProfileInfoEvent);
    on<UpdateFamilyMemberListEvent>(_onUpdateFamilyMemberListEvent);
    on<AddUserUnitCarEvent>(_onAddUserUnitCarEvent);
    on<UpdateUserUnitCarEvent>(_onUpdateUserUnitCarEvent);
    on<SelectMultiImageEvent>(_onSelectMultiImageEvent);
    on<ShowQrSearchableBottomSheetEvent>(_onShowQrSearchableBottomSheetEvent);
    on<UpdateSearchableSingleQuestionEvent>(
        _onUpdateSearchableSingleQuestionEvent);
    on<UpdateSearchableMultiQuestionEvent>(
        _onUpdateSearchableMultiQuestionEvent);
  }

  FutureOr<void> _onStepPressedEvent(
      StepPressedEvent event, Emitter<ProfileState> emit) {
    emit(ChangeCurrentStepState(index: event.index));
  }

  FutureOr<void> _onNavigateBackEvent(
      NavigateBackEvent event, Emitter<ProfileState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> _onUploadProfileImagePressedEvent(
      UploadProfileImagePressedEvent event, Emitter<ProfileState> emit) {
    emit(OpenMediaBottomSheetState());
  }

  FutureOr<void> _onCameraPressedEvent(
      CameraPressedEvent event, Emitter<ProfileState> emit) {
    emit(OpenCameraState(
      file: event.file,
      questions: event.questions,
      question: event.question,
      index: event.index,
    ));
  }

  FutureOr<void> _onGalleryPressedEvent(
      GalleryPressedEvent event, Emitter<ProfileState> emit) {
    emit(OpenGalleryState(
      file: event.file,
      questions: event.questions,
      question: event.question,
      index: event.index,
      isMultiImage: event.isMultiImage,
    ));
  }

  FutureOr<void> _onSelectImageEvent(
      SelectImageEvent event, Emitter<ProfileState> emit) async {
    emit(ShowLoadingState());
    final DataState<ProfileImage> dataState =
        await _updateUserImageUseCase(event.imagePath);
    if (dataState is DataSuccess) {
      User user = _getUserInformationUseCase();
      user = user.copyWith(
        userInformation: user.userInformation.copyWith(
          image: dataState.data?.image ?? "",
        ),
      );
      await _saveUserInformationUseCase(user);
      emit(DisplayProfileImageState(
          imagePath: event.imagePath, message: dataState.message ?? ""));
    } else {
      emit(GetUserProfileErrorState(message: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onAskForCameraPermissionEvent(
      AskForCameraPermissionEvent event, Emitter<ProfileState> emit) {
    emit(AskForCameraPermissionState(
      onTab: event.onTab,
      permission: event.permission,
    ));
  }

  FutureOr<void> _onAddPressedEvent(
      AddPressedEvent event, Emitter<ProfileState> emit) {
    if (event.page == 4) {
      emit(NavigateToAddFamilyMemberScreenState(
          isUpdate: event.isUpdate, familyMember: event.familyMember));
    } else if (event.page == 5) {
      emit(OpenAddCarBottomSheetState(car: event.car));
    }
  }

  FutureOr<void> _onDeleteFamilyMemberEvent(
      DeleteFamilyMemberEvent event, Emitter<ProfileState> emit) async {
    emit(ShowLoadingState());

    final DataState dataState = await _deleteUserFamilyMemberUseCase(
        DeleteRequest(id: event.familyMember.id.toString()));
    if (dataState is DataSuccess) {
      emit(DeleteFamilyMemberSuccessState(
        message: dataState.message ?? "",
        familyMember: event.familyMember,
      ));
    } else {
      emit(DeleteFamilyMemberErrorState(errorMessage: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onDeleteCarEvent(
      DeleteCarEvent event, Emitter<ProfileState> emit) async {
    emit(ShowLoadingState());

    final deleteCarState = await _deleteUserUnitCarUseCase(
        DeleteRequest(id: event.car.id.toString()));
    if (deleteCarState is DataSuccess) {
      final updatedCarsAfterDeletion = _deleteCarUseCase(event.cars, event.car);
      emit(DeleteCarSuccessState(
          message: deleteCarState.message ?? "",
          cars: updatedCarsAfterDeletion));
    } else if (deleteCarState is DataFailed) {
      emit(DeleteCarErrorState(errorMessage: deleteCarState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onUploadFileImageEvent(
      UploadFileImageEvent event, Emitter<ProfileState> emit) {
    emit(OpenMediaBottomSheetState(
      file: event.file,
      index: event.index,
      isMultiImage: event.isMultiImage,
    ));
  }

  FutureOr<void> _onSelectFileImageEvent(
      SelectFileImageEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].id == event.file.id) {
        event.files[i] = event.file;
        event.files[i] =
            event.files[i].copyWith(errorMessage: "", isChanged: true);

        break;
      }
    }
    emit(SelectFileImageState(files: event.files));
  }

  FutureOr<void> _onDeleteFileImageEvent(
      DeleteFileImageEvent event, Emitter<ProfileState> emit) async {
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].id == event.file.id) {
        if (event.files[i].code == QuestionsCode.multiImage) {
          List<String> images = event.files[i].value.split(",");
          images.removeAt(event.index);
          event.files[i] = event.file.copyWith(value: images.join(","));
        } else {
          event.files[i] = event.file;
          event.files[i] = event.files[i].copyWith(
            value: "",
          );
        }
        break;
      }
    }
    emit(DeleteFileImageState(
        files: event.files,
        isMultiImage: event.isMultiImage,
        index: event.index));
  }

  FutureOr<void> _onUploadFileDocumentEvent(
      UploadFileDocumentEvent event, Emitter<ProfileState> emit) {
    emit(UploadFileDocumentState(file: event.file));
  }

  FutureOr<void> _onAskForStoragePermissionEvent(
      AskForStoragePermissionEvent event, Emitter<ProfileState> emit) {
    emit(AskForStoragePermissionState(file: event.file));
  }

  FutureOr<void> _onSelectFileDocumentEvent(
      SelectFileDocumentEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].id == event.file.id) {
        event.files[i] = event.file;
        event.files[i] =
            event.files[i].copyWith(errorMessage: "", isChanged: true);

        break;
      }
    }
    emit(SelectFileDocumentState(files: event.files));
  }

  FutureOr<void> _onDeleteFileDocumentEvent(
      DeleteFileDocumentEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].id == event.file.id) {
        event.files[i] = event.file;
        event.files[i] = event.files[i].copyWith(
          value: "",
        );
        break;
      }
    }

    emit(DeleteFileImageState(files: event.files));
  }

  FutureOr<void> _onSaveFilesPressedEvent(
      SaveFilesPressedEvent event, Emitter<ProfileState> emit) async {
    bool isValid = true;
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].value.isEmpty && event.files[i].isMandatory) {
        event.files[i] = event.files[i]
            .copyWith(errorMessage: S.current.thisFieldIsRequired);
        isValid = false;
      }
      if (event.files[i].code == QuestionsCode.multiImage &&
          event.files[i].isMandatory) {
        List<String> images = [];
        if (event.files[i].value.isNotEmpty) {
          images = event.files[i].value.split(",").toList();
        }
        if (images.length < event.files[i].minCount) {
          event.files[i] = event.files[i].copyWith(
              errorMessage:
                  "${S.current.youCanUploadAMinimumOf} ${event.files[i].minCount} ${S.current.imageAndAMaximumOf} ${event.files[i].maxCount} ${S.current.image}");
          isValid = false;
        }
      }
    }
    if (isValid) {
      emit(ShowLoadingState());

      final DataState dataState = await _updateUserDocumentsUseCase(
        event.files.mapToRequest(),
      );
      if (dataState is DataSuccess) {
        emit(SaveFilesSuccessState(messge: dataState.message ?? ""));
      } else {
        emit(SaveFilesErrorState(
          errorMessage: dataState.message ?? "",
        ));
      }

      emit(HideLoadingState());
    } else {
      emit(InvalidFilesFormState(files: event.files));
    }
  }

  FutureOr<void> _onValidateGasNumberEvent(
      ValidateGasNumberEvent event, Emitter<ProfileState> emit) {
    if (event.value.isEmpty) {
      emit(InvalidGasNumberState(
          errorMessage: S.current.gasNumberCanNotBeEmpty));
    } else {
      emit(ValidGasNumberState());
    }
  }

  FutureOr<void> _onValidateTelephoneEvent(
      ValidateTelephoneEvent event, Emitter<ProfileState> emit) {
    if (event.value.isEmpty) {
      emit(InvalidTelephoneState(
          errorMessage: S.current.telephoneCanNotBeEmpty));
    } else {
      emit(ValidTelephoneState());
    }
  }

  FutureOr<void> _onUnitSaveButtonPressedEvent(
      UnitSaveButtonPressedEvent event, Emitter<ProfileState> emit) {
    bool isValid = true;
    if (event.unit.gasNumber.isEmpty) {
      emit(InvalidGasNumberState(
          errorMessage: S.current.gasNumberCanNotBeEmpty));
      isValid = false;
    }

    // if (event.unit.telephone.isEmpty) {
    //   emit(InvalidTelephoneState(
    //       errorMessage: S.current.telephoneCanNotBeEmpty));
    //   isValid = false;
    // }

    if (isValid) {
      emit(ValidProfileUnitFormState(unit: event.unit));
    }
  }

  FutureOr<void> _onUpdateProfileUnitEvent(
      UpdateProfileUnitEvent event, Emitter<ProfileState> emit) async {
    emit(ShowLoadingState());
    final DataState dataState = await _updateUserUnitUseCase(event.request);
    if (dataState is DataSuccess) {
      emit(UpdateProfileUnitSuccessState(message: dataState.message ?? ""));
    } else {
      emit(UpdateProfileUnitErrorState(errorMessage: dataState.message ?? ""));
    }

    emit(HideLoadingState());
  }

  FutureOr<void> _onSelectProfileUnitUserTypeEvent(
      SelectProfileUnitUserTypeEvent event, Emitter<ProfileState> emit) {
    emit(SelectProfileUnitUserTypeState(userType: event.userType));
  }

  FutureOr<void> _onValidateInfoNameEvent(
      ValidateInfoNameEvent event, Emitter<ProfileState> emit) {
    ProfileInfoValidationState validation =
        ProfileInfoValidator.validateName(event.value);
    if (validation == ProfileInfoValidationState.nameEmpty) {
      emit(InvalidInfoNameState(errorMessage: S.current.nameCantBeEmpty));
    } else if (validation == ProfileInfoValidationState.invalidName) {
      emit(InvalidInfoNameState(
          errorMessage: S.current.enterTwoWordsEachWordContains2Characters));
    } else {
      emit(ValidInfoNameState());
    }
  }

  FutureOr<void> _onValidateInfoEmailEvent(
      ValidateInfoEmailEvent event, Emitter<ProfileState> emit) {
    ProfileInfoValidationState validation =
        ProfileInfoValidator.validateEmailAddress(event.value);

    if (validation == ProfileInfoValidationState.emailEmpty) {
      emit(InvalidInfoEmailState(
          errorMessage: S.current.emailAddressCantBeEmpty));
    } else if (validation == ProfileInfoValidationState.invalidEmailAddress) {
      emit(InvalidInfoEmailState(errorMessage: S.current.invalidEmailAddress));
    } else {
      emit(ValidInfoEmailState());
    }
  }

  FutureOr<void> _onSelectSingleSelectionAnswerEvent(
      SelectSingleSelectionAnswerEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answerId) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: !event.questions[i].choices[j].isSelected,
            );
            if (event.questions[i].choices[j].isSelected == true) {
              event.questions[i] =
                  event.questions[i].copyWith(notAnswered: false);
            } else {
              event.questions[i] =
                  event.questions[i].copyWith(notAnswered: true);
            }
          } else {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: false,
            );
          }
        }
      }
    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onSelectMultiSelectionAnswerEvent(
      SelectMultiSelectionAnswerEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answerId) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: !event.questions[i].choices[j].isSelected,
            );
          }
        }
      }
    }

    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(notAnswered: true);
        for (int j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].isSelected) {
            event.questions[i] =
                event.questions[i].copyWith(notAnswered: false);
          }
        }
        break;
      }
    }

    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onDeleteQuestionAnswerEvent(
      DeleteQuestionAnswerEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] =
            event.questions[i].copyWith(value: "", notAnswered: true);
      }
    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onAddAnswerToQuestionEvent(
      AddAnswerToQuestionEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: event.answer,
          notAnswered: false,
        );
      }

      if (event.questions[i].value.isNotEmpty) {
        Map<String,dynamic> validation = _dynamicQuestionValidationUseCase(
          validation: event.questions[i].validations,
          value: event.questions[i].value,
          questionCode: event.questions[i].code,
        );
        if (!validation["isValid"]) {
          event.questions[i] = event.questions[i].copyWith(
            isValid: false,
            validationMessage: validation["validationMessage"],
          );
        } else {
          event.questions[i] = event.questions[i].copyWith(
            isValid: true,
            validationMessage: ""
          );
        }
      } else {
        event.questions[i] = event.questions[i].copyWith(
          isValid: true,
        );
      }

    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onSelectQuestionImageEvent(
      SelectQuestionImageEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
            value: event.imagePath, notAnswered: false, isFromServer: false);
      }
    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onUploadProfileInfoImage(
      UploadProfileInfoImage event, Emitter<ProfileState> emit) {
    emit(OpenMediaBottomSheetState(
      questions: event.questions,
      question: event.question,
    ));
  }

  FutureOr<void> _onDeleteQuestionImageEvent(
      DeleteQuestionImageEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: "",
          notAnswered: true,
          isFromServer: false,
        );
      }
    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onInfoSaveButtonPressedEvent(
      InfoSaveButtonPressedEvent event, Emitter<ProfileState> emit) {
    bool isValid = true;
    String? nameErrorMessage;
    String? emailErrorMessage;
    List<ProfileInfoValidationState> validations =
        _profileInfoFormValidationUseCase(
      event.info,
    );

    for (var validation in validations) {
      if (validation == ProfileInfoValidationState.nameEmpty) {
        nameErrorMessage = S.current.nameCantBeEmpty;
        isValid = false;
      } else if (validation == ProfileInfoValidationState.invalidName) {
        nameErrorMessage = S.current.enterTwoWordsEachWordContains2Characters;
        isValid = false;
      } else if (validation == ProfileInfoValidationState.emailEmpty) {
        emailErrorMessage = S.current.emailAddressCantBeEmpty;
        isValid = false;
      } else if (validation == ProfileInfoValidationState.invalidEmailAddress) {
        emailErrorMessage = S.current.invalidEmailAddress;
        isValid = false;
      }
    }
    for (int i = 0; i < event.info.fields.length; i++) {
      if (event.info.fields[i].isRequired && event.info.fields[i].notAnswered) {
        isValid = false;
      }
    }

    if (isValid) {
      emit(ValidProfileInfoFormState(info: event.info));
    } else {
      emit(InvalidProfileInfoFormState(
        questions: event.info.fields,
        nameErrorMessage: nameErrorMessage,
        emailErrorMessage: emailErrorMessage,
      ));
    }
  }

  FutureOr<void> _onUpdateProfileInfoEvent(
      UpdateProfileInfoEvent event, Emitter<ProfileState> emit) async {
    emit(ShowLoadingState());

    for (int i = 0; i < event.info.fields.length; i++) {
      if (event.info.fields[i].code == QuestionsCode.singleChoice) {
        for (int j = 0; j < event.info.fields[i].choices.length; j++) {
          if (event.info.fields[i].choices[j].isSelected) {
            event.info.fields[i] = event.info.fields[i]
                .copyWith(value: event.info.fields[i].choices[j].id.toString());
          }
        }
      } else if (event.info.fields[i].code == QuestionsCode.multiChoice) {
        event.info.fields[i] = event.info.fields[i].copyWith(value: "");
        for (int j = 0; j < event.info.fields[i].choices.length; j++) {
          if (event.info.fields[i].choices[j].isSelected) {
            if (event.info.fields[i].value == "") {
              event.info.fields[i] = event.info.fields[i].copyWith(
                  value: event.info.fields[i].choices[j].id.toString());
            } else {
              event.info.fields[i] = event.info.fields[i].copyWith(
                  value:
                      "${event.info.fields[i].value},${event.info.fields[i].choices[j].id.toString()}");
            }
          }
        }
      }
    }
    UpdateInfoRequest request = UpdateInfoRequest(
      name: event.info.name,
      email: event.info.email,
      mobileNumber: event.info.mobileNumber,
      extraFields: event.info.fields.mapToInfoRequestFiles(),
    );
    final DataState dataState = await _updateUserInfoUseCase(request);
    if (dataState is DataSuccess) {
      User user = _getUserInformationUseCase();
      user = user.copyWith(
        userInformation: user.userInformation.copyWith(
          name: event.info.name,
          email: event.info.email,
        ),
      );
      await _saveUserInformationUseCase(user);
      emit(UpdateProfileInfoSuccessState(message: dataState.message ?? ""));
    } else {
      emit(UpdateProfileInfoErrorState(errorMessage: dataState.message ?? ""));
    }
    emit(HideLoadingState());
  }

  FutureOr<void> _onSelectFileExpireDateEvent(
      SelectFileExpireDateEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].id == event.file.id) {
        event.files[i] = event.files[i].copyWith(
            expireDate: event.date.toString().split(" ").isNotEmpty
                ? event.date.toString().split(" ")[0]
                : "");
        break;
      }
    }

    emit(SelectFileDateState(files: event.files));
  }

  FutureOr<void> _onGetUserProfileEvent(
      GetUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ShowSkeletonState());
    Profile profile = const Profile();
    CarConfiguration carConfiguration = const CarConfiguration();
    final DataState<List<Lookup>> configurationState =
        await _getLookupDataUseCase([
      const LookupRequest(lookupCode: LookupKeys.colors),
      const LookupRequest(lookupCode: LookupKeys.carType),
      const LookupRequest(lookupCode: LookupKeys.carModel),
      const LookupRequest(lookupCode: LookupKeys.relationshipType),
    ]);
    final DataState dataState = await _getUserProfileUseCase();

    if (dataState is DataSuccess && configurationState is DataSuccess) {
      profile = dataState.data;
      carConfiguration = carConfiguration.copyWith(
        colors: configurationState.data?[0].files ?? [],
        types: configurationState.data?[1].files ?? [],
        models: configurationState.data?[2].files ?? [],
      );
      profile = profile.copyWith(
        familyMemberTypes:
            configurationState.data?.last.files.toFamilyMemberTypes() ?? [],
        carConfiguration: carConfiguration,
      );
      for (int i = 0; i < profile.info.fields.length; i++) {
        if (profile.info.fields[i].code == QuestionsCode.singleChoice ||
            profile.info.fields[i].code == QuestionsCode.multiChoice ||
            profile.info.fields[i].code == QuestionsCode.searchableSingle ||
            profile.info.fields[i].code == QuestionsCode.searchableMulti) {

          if (profile.info.fields[i].value.isNotEmpty) {
            List<int> choices = [];
            try{
              choices = profile.info.fields[i].value
                  .split(",")
                  .map((e) => int.parse(e))
                  .toList();
            } catch (e) {
              print(e.toString());
            }
            for (int j = 0; j < profile.info.fields[i].choices.length; j++) {
              for (int k = 0; k < choices.length; k++) {
                if (profile.info.fields[i].choices[j].id == choices[k]) {
                  profile.info.fields[i].choices[j] =
                      profile.info.fields[i].choices[j].copyWith(
                    isSelected: true,
                  );
                }
              }
            }
          }
        } else if (profile.info.fields[i].code == QuestionsCode.image) {
          if (profile.info.fields[i].value.isNotEmpty) {
            profile.info.fields[i] = profile.info.fields[i].copyWith(
              isFromServer: true,
            );
          }
        }
      }

      for (var i = 0; i < profile.family.length; i++) {
        GlobalKey key = GlobalKey();
        profile.family[i] = profile.family[i].copyWith(key: key);
      }

      emit(GetUserProfileSuccessState(
        profile: profile,
      ));
    } else if (dataState is DataFailed) {
      emit(GetUserProfileErrorState(message: dataState.message ?? ""));
    } else if (configurationState is DataFailed) {
      emit(GetUserProfileErrorState(message: configurationState.message ?? ""));
    }
    // emit(HideLoadingState());
  }

  FutureOr<void> _onUpdateFamilyMemberListEvent(
      UpdateFamilyMemberListEvent event, Emitter<ProfileState> emit) {
    emit(UpdateFamilyMemberListState(familyMembers: event.familyMembers));
  }

  FutureOr<void> _onAddUserUnitCarEvent(
      AddUserUnitCarEvent event, Emitter<ProfileState> emit) {
    emit(SuccessAddUserUnitCarState(event.cars));
  }

  FutureOr<void> _onUpdateUserUnitCarEvent(
      UpdateUserUnitCarEvent event, Emitter<ProfileState> emit) {
    emit(SuccessUpdateUserUnitCarState(event.cars));
  }

  FutureOr<void> _onSelectMultiImageEvent(
      SelectMultiImageEvent event, Emitter<ProfileState> emit) {
    for (int i = 0; i < event.files.length; i++) {
      if (event.files[i].id == event.file.id) {
        event.files[i] = event.file;
        event.files[i] =
            event.files[i].copyWith(errorMessage: "", isChanged: true);

        break;
      }
    }

    emit(SelectMultiImagesState(files: event.files));
  }

  FutureOr<void> _onShowQrSearchableBottomSheetEvent(
      ShowQrSearchableBottomSheetEvent event, Emitter<ProfileState> emit) {
    emit(ShowQrSearchableBottomSheetState(
        questions: event.questions,
        question: event.question,
        isMultiChoice: event.isMultiChoice));
  }

  void _onUpdateSearchableSingleQuestionEvent(
      UpdateSearchableSingleQuestionEvent event, Emitter<ProfileState> emit) {
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: event.answer.id.toString(),
          notAnswered: false,
        );
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          if (event.questions[i].choices[j].id == event.answer.id) {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: true,
            );
            event.questions[i] =
                event.questions[i].copyWith(notAnswered: false);
          } else {
            event.questions[i].choices[j] =
                event.questions[i].choices[j].copyWith(
              isSelected: false,
            );
          }
        }

        if (event.questions[i].value.isNotEmpty) {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: false,
          );
        } else {
          event.questions[i] =
              event.questions[i].copyWith(value: "", notAnswered: false);
        }
      }
    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }

  FutureOr<void> _onUpdateSearchableMultiQuestionEvent(
      UpdateSearchableMultiQuestionEvent event, Emitter<ProfileState> emit) {
    bool isAnswered = false;
    for (var i = 0; i < event.questions.length; i++) {
      if (event.questions[i].id == event.question.id) {
        event.questions[i] = event.questions[i].copyWith(
          value: "",
        );
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          event.questions[i].choices[j] =
              event.questions[i].choices[j].copyWith(
            isSelected: false,
          );
        }
        for (var j = 0; j < event.questions[i].choices.length; j++) {
          for (var k = 0; k < event.answer.length; k++) {
            if (event.questions[i].choices[j].id == event.answer[k].id) {
              event.questions[i].choices[j] =
                  event.questions[i].choices[j].copyWith(
                isSelected: true,
              );
              event.questions[i] = event.questions[i].copyWith(
                value: event.questions[i].value == ""
                    ? event.questions[i].choices[j].id.toString()
                    : event.questions[i].value.contains(
                            event.questions[i].choices[j].id.toString())
                        ? event.questions[i].value
                        : "${event.questions[i].value},${event.questions[i].choices[j].id.toString()}",
                notAnswered: false,
              );
              isAnswered = true;
            }
          }
        }
        if (isAnswered) {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: false,
          );
        } else {
          event.questions[i] = event.questions[i].copyWith(
            notAnswered: true,
          );
        }
      }
    }
    emit(UpdateProfileInfoQuestionsState(questions: event.questions));
  }
}
