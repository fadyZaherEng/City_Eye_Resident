import 'dart:async';
import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/android_date_picker.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/convert_asset_entities_to_files.dart';
import 'package:city_eye/src/core/utils/convert_assets_to_files.dart';
import 'package:city_eye/src/core/utils/ios_date_picker.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_searchable_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_unit_request.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/profile/car.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/info.dart';
import 'package:city_eye/src/domain/entities/profile/profile.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:city_eye/src/domain/entities/profile/profile_unit.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/steps/steps.dart';
import 'package:city_eye/src/domain/entities/wall/images_screen.dart';
import 'package:city_eye/src/domain/entities/wall/wall_attachment.dart';
import 'package:city_eye/src/presentation/blocs/profile/profile_bloc.dart';
import 'package:city_eye/src/presentation/screens/profile/skeleton/profile_screen_skeleton.dart';
import 'package:city_eye/src/presentation/screens/profile/utils/show_add_car_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/profile/utils/show_add_family_member_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/cars_widget.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/family_widget.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/files_widget.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/info_widget.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/unit_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/steps_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ProfileScreen extends BaseStatefulWidget {
  final int? index;
  final int? scrollId;

  const ProfileScreen({this.index, this.scrollId, Key? key}) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  ProfileBloc get _bloc => BlocProvider.of<ProfileBloc>(context);

  late PageController _pageController;
  int _currentIndex = 1;

  Profile _profile = Profile();
  bool _isImageLocal = false;
  String? _gasNumberErrorMessage;
  String? _telephoneErrorMessage;
  String? _nameErrorMessage;
  String? _emailErrorMessage;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _gasNumberKey = GlobalKey();
  final GlobalKey _telephoneKey = GlobalKey();
  final GlobalKey _nameKey = GlobalKey();
  final GlobalKey _emailKey = GlobalKey();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _gasNumberController = TextEditingController();
  TextEditingController _compoundNameController = TextEditingController();
  TextEditingController _unitNumberController = TextEditingController();

  int _maxMultipleImages = 0;
  int _minMultipleImages = 0;
  int selectedMultiImagesCount = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];
  List<String> multiServerImages = [];

  bool isUpdateFamilyMemberList = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 1;
    _bloc.add(GetUserProfileEvent());
    _pageController = PageController();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetUserProfileSuccessState) {
          _profile = state.profile;
          _fullNameController.text = _profile.info.name;
          _emailAddressController.text = _profile.info.email;
          _mobileNumberController.text = "\u200E${_profile.info.mobileNumber}";
          _compoundNameController.text = _profile.unit.compoundName;
          _unitNumberController.text = _profile.unit.unitName;
          _gasNumberController.text = _profile.unit.gasNumber;
          _telephoneController.text = _profile.unit.telephone;

          if (_currentIndex == widget.index || _currentIndex != 0) {
            await Future.delayed(const Duration(milliseconds: 100));
            _onTabStepEvent(_currentIndex);
          }
        } else if (state is GetUserProfileErrorState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is ChangeCurrentStepState) {
          _changeCurrentStep(state.index);
        } else if (state is OpenMediaBottomSheetState) {
          showBottomSheetUploadMedia(
            context: context,
            onTapGallery: () async {
              _navigateBackEvent();
              _askForCameraPermissionEvent(
                () {
                  _galleryPressedEvent(
                    file: state.file,
                    questions: state.questions,
                    question: state.question,
                    isMultiImage: state.isMultiImage,
                  );
                },
                permission: state.isMultiImage
                    ? PermissionServiceHandler.getGalleryPermission(
                        state.isMultiImage,
                        androidDeviceInfo: Platform.isAndroid
                            ? await DeviceInfoPlugin().androidInfo
                            : null,
                      )
                    : PermissionServiceHandler
                        .getSingleImageGalleryPermission(),
              );
            },
            onTapCamera: () {
              _navigateBackEvent();
              _askForCameraPermissionEvent(
                () {
                  _cameraPressedEvent(
                    file: state.file,
                    questions: state.questions,
                    question: state.question,
                  );
                },
              );
            },
          );
        } else if (state is AskForCameraPermissionState) {
          _askForCameraPermission(state.onTab, permission: state.permission);
        } else if (state is UploadFileDocumentState) {
          _askForStoragePermissionEvent(state.file);
        } else if (state is AskForStoragePermissionState) {
          _askForStoragePermission(state.file);
        } else if (state is OpenCameraState) {
          _getImage(
            ImageSource.camera,
            file: state.file,
            questions: state.questions,
            question: state.question,
            index: state.index,
          );
        } else if (state is OpenGalleryState) {
          _getImage(
            ImageSource.gallery,
            file: state.file,
            questions: state.questions,
            question: state.question,
            index: state.index,
            isMultiImage: state.isMultiImage,
          );
        } else if (state is DisplayProfileImageState) {
          _isImageLocal = true;
          _profile = _profile.copyWith(
            info: _profile.info.copyWith(image: state.imagePath),
          );
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is NavigateBackState) {
          _navigateBack();
        } else if (state is NavigateToAddFamilyMemberScreenState) {
          showAddNewFamilyMemberBottomSheetWidget(
            context: context,
            familyMember: state.familyMember,
            familyMembersTypes: _profile.familyMemberTypes,
            isUpdate: state.isUpdate,
            height: MediaQuery.of(context).size.height * 0.7,
            isUpdateFamilyMemberList: (List<FamilyMember> familyMembers) {
              _bloc.add(UpdateFamilyMemberListEvent(
                familyMembers: familyMembers,
              ));
            },
          );
        } else if (state is DeleteFamilyMemberSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
          _profile.family.remove(state.familyMember);
        } else if (state is DeleteFamilyMemberErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is OpenAddCarBottomSheetState) {
          showAddCarBottomSheetWidget(
            context: context,
            carConfiguration: _profile.carConfiguration,
            height: MediaQuery.of(context).size.height * 0.6,
            car: state.car,
            onTapAdd: (cars) {
              _navigateBack();
              _addUserUnitCarEvent(cars);
            },
            onTapUpdate: (cars) {
              _navigateBack();
              _updateUserUnitCarEvent(cars);
            },
          );
        } else if (state is SuccessAddUserUnitCarState) {
          _profile = _profile.copyWith(cars: state.cars);
        } else if (state is SuccessUpdateUserUnitCarState) {
          _profile = _profile.copyWith(cars: state.cars);
        } else if (state is DeleteCarSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
          _profile = _profile.copyWith(
            cars: state.cars,
          );
        } else if (state is DeleteCarErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is SelectFileImageState) {
          _profile = _profile.copyWith(
            files: state.files,
          );
        } else if (state is SelectMultiImagesState) {
          _profile = _profile.copyWith(
            files: state.files,
          );
        } else if (state is DeleteFileImageState) {
          _profile = _profile.copyWith(
            files: state.files,
          );

          if (state.isMultiImage && state.index != -1) {
            if (multiServerImages.isNotEmpty &&
                state.index < multiServerImages.length) {
              multiServerImages.removeAt(state.index);
            } else if (imagesAssets.isNotEmpty &&
                state.index <= imagesAssets.length &&
                state.index >= multiServerImages.length) {
              imagesAssets.removeAt(state.index - (multiServerImages.length));
            } else if (cameraImages.isNotEmpty) {
              cameraImages.removeAt(state.index -
                  (imagesAssets.length + multiServerImages.length));
              selectedMultiImagesCount--;
            }
          }
        } else if (state is SelectFileDocumentState) {
          _profile = _profile.copyWith(
            files: state.files,
          );
        } else if (state is DeleteFileDocumentState) {
          _profile = _profile.copyWith(
            files: state.files,
          );
        } else if (state is SaveFilesSuccessState) {
          showSnackBar(
            context: context,
            message: state.messge,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is SaveFilesErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is InvalidFilesFormState) {
          for (var file in state.files) {
            if (file.errorMessage.isNotEmpty) {
              _animateTo(file.key);
              break;
            }
          }
        } else if (state is ValidGasNumberState) {
          _gasNumberErrorMessage = null;
        } else if (state is InvalidGasNumberState) {
          _gasNumberErrorMessage = state.errorMessage;
          _animateTo(_gasNumberKey);
        } else if (state is ValidTelephoneState) {
          _telephoneErrorMessage = null;
        } else if (state is InvalidTelephoneState) {
          _telephoneErrorMessage = state.errorMessage;
          _animateTo(_telephoneKey);
        } else if (state is ValidProfileUnitFormState) {
          _updateProfileUnitRequest(unit: state.unit);
        } else if (state is UpdateProfileUnitSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is UpdateProfileUnitErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is SelectProfileUnitUserTypeState) {
          _profile = _profile.copyWith(
            unit: _profile.unit.copyWith(
                userType: _profile.unit.userType.copyWith(id: state.userType)),
          );
        } else if (state is ValidInfoNameState) {
          _nameErrorMessage = null;
        } else if (state is InvalidInfoNameState) {
          _nameErrorMessage = state.errorMessage;
        } else if (state is ValidInfoEmailState) {
          _emailErrorMessage = null;
        } else if (state is InvalidInfoEmailState) {
          _emailErrorMessage = state.errorMessage;
        } else if (state is UpdateProfileInfoQuestionsState) {
          _profile = _profile.copyWith(
            info: _profile.info.copyWith(
              fields: state.questions,
            ),
          );
        } else if (state is ValidProfileInfoFormState) {
          _bloc.add(UpdateProfileInfoEvent(info: state.info));
        } else if (state is UpdateProfileInfoSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is UpdateProfileInfoErrorState) {
          showSnackBar(
            context: context,
            message: state.errorMessage,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is InvalidProfileInfoFormState) {
          bool isNavigated = false;
          if (state.nameErrorMessage != null) {
            isNavigated = true;
            _nameErrorMessage = state.nameErrorMessage;
            _animateTo(_nameKey);
          }
          if (state.emailErrorMessage != null) {
            _emailErrorMessage = state.emailErrorMessage;
            if (!isNavigated) _animateTo(_emailKey);
            isNavigated = true;
          }
          _profile = _profile.copyWith(
            info: _profile.info.copyWith(
              fields: state.questions,
            ),
          );

          for (var question in state.questions) {
            if (question.notAnswered == true && !isNavigated) {
              if (!isNavigated) _animateTo(question.key);
              isNavigated = true;
              break;
            }
          }
        } else if (state is UpdateFamilyMemberListState) {
          _profile = _profile.copyWith(family: state.familyMembers);
        } else if (state is ShowQrSearchableBottomSheetState) {
          _openSearchableBottomSheet(
              state.questions, state.question, state.isMultiChoice);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Scaffold(
            appBar: buildAppBarWidget(
              context,
              title: S.of(context).profile,
              isHaveBackButton: true,
              onBackButtonPressed: () {
                _navigateBackEvent();
              },
            ),
            floatingActionButton: _buildAddWidget(_currentIndex),
            body: state is ShowSkeletonState
                ? const ProfileScreenSkeleton()
                : Column(
                    children: [
                      StepsWidget(
                        isProfile: true,
                        steps: [
                          Steps(id: 1, name: S.of(context).info),
                          Steps(id: 2, name: S.of(context).unit),
                          Steps(id: 3, name: S.of(context).files),
                          Steps(id: 4, name: S.of(context).family),
                          Steps(id: 5, name: S.of(context).cars),
                        ],
                        pages: [
                          InfoWidget(
                            scrollController: _scrollController,
                            fullNameController: _fullNameController,
                            emailAddressController: _emailAddressController,
                            mobileNumberController: _mobileNumberController,
                            info: _profile.info,
                            nameKey: _nameKey,
                            emailKey: _emailKey,
                            nameErrorMessage: _nameErrorMessage,
                            emailErrorMessage: _emailErrorMessage,
                            onNameChanged: (value) {
                              _bloc.add(ValidateInfoNameEvent(value: value));
                            },
                            onEmailChanged: (value) {
                              _bloc.add(ValidateInfoEmailEvent(value: value));
                            },
                            isImageLocal: _isImageLocal,
                            onCameraTab: () {
                              _openMediaBottomSheetEvent();
                            },
                            onImageProfilePreview: (imagePath) {
                              Navigator.pushNamed(context, Routes.wallImages,
                                  arguments: ImagesScreen(
                                    initialIndex: 0,
                                    images: [
                                      WallAttachment(attachment: imagePath)
                                    ],
                                  ));
                            },
                            selectItem: (questions, question, answerId) {
                              _bloc.add(SelectMultiSelectionAnswerEvent(
                                questions: questions,
                                question: question,
                                answerId: answerId,
                              ));
                            },
                            selectSingleSelection:
                                (questions, question, answerId) {
                              _bloc.add(SelectSingleSelectionAnswerEvent(
                                questions: questions,
                                question: question,
                                answerId: answerId,
                              ));
                            },
                            addAnswer: (questions, question, answer) {
                              _bloc.add(AddAnswerToQuestionEvent(
                                questions: questions,
                                question: question,
                                answer: answer,
                              ));
                            },
                            deleteAnswer: (questions, question) {
                              _bloc.add(DeleteQuestionAnswerEvent(
                                questions: questions,
                                question: question,
                              ));
                            },
                            onImageTab: (questions, question) {
                              _bloc.add(UploadProfileInfoImage(
                                questions: questions,
                                question: question,
                              ));
                            },
                            onImageDelete: (questions, question) {
                              _showActionDialog(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisImage,
                                primaryText: S.of(context).no,
                                onPrimaryAction: () {
                                  _navigateBackEvent();
                                },
                                secondaryText: S.of(context).yes,
                                onSecondaryAction: () {
                                  _bloc.add(DeleteQuestionImageEvent(
                                    questions: questions,
                                    question: question,
                                  ));
                                  _navigateBackEvent();
                                },
                              );
                            },
                            onOpenSearchableBottomSheet:
                                (questions, element, isMultiChoice) {
                              _bloc.add(ShowQrSearchableBottomSheetEvent(
                                  questions: questions,
                                  question: element,
                                  isMultiChoice: isMultiChoice));
                            },
                            onSave: (info) {
                              Info tempInfo = info.copyWith(
                                image: _isImageLocal ? info.image : "",
                              );
                              // print(tempInfo);
                              _bloc.add(InfoSaveButtonPressedEvent(
                                info: tempInfo,
                              ));
                            },
                          ),
                          UnitWidget(
                            gasNumberController: _gasNumberController,
                            telephoneController: _telephoneController,
                            compoundNameController: _compoundNameController,
                            unitNumberController: _unitNumberController,
                            unit: _profile.unit,
                            gasNumberKey: _gasNumberKey,
                            // telephoneKey: _telephoneKey,
                            onSelectUserType: (userType) {
                              _bloc.add(SelectProfileUnitUserTypeEvent(
                                  userType: userType));
                            },
                            onGasNumberChanged: (value) {
                              _bloc.add(ValidateGasNumberEvent(value: value));
                            },
                            onTelephoneChanged: (value) {
                              // _bloc.add(ValidateTelephoneEvent(value: value));
                            },
                            gasNumberErrorMessage: _gasNumberErrorMessage,
                            // telephoneErrorMessage: _telephoneErrorMessage,
                            onSavePressed: (ProfileUnit unit) {
                              _bloc.add(UnitSaveButtonPressedEvent(
                                unit: unit,
                              ));
                            },
                          ),
                          FilesWidget(
                            files: _profile.files,
                            onDelete: (file) {
                              if (file.isEditable) {
                                _showActionDialog(
                                  icon: ImagePaths.warning,
                                  text: S
                                      .of(context)
                                      .areYouSureYouWantToDeleteThisFile,
                                  primaryText: S.of(context).no,
                                  onPrimaryAction: () {
                                    _navigateBackEvent();
                                  },
                                  secondaryText: S.of(context).yes,
                                  onSecondaryAction: () {
                                    if (file.code == QuestionsCode.image) {
                                      _bloc.add(DeleteFileImageEvent(
                                        files: _profile.files,
                                        file: file,
                                      ));
                                    } else if (file.code ==
                                        QuestionsCode.file) {
                                      _bloc.add(DeleteFileDocumentEvent(
                                        files: _profile.files,
                                        file: file,
                                      ));
                                    }
                                    _navigateBackEvent();
                                  },
                                );
                              } else {
                                showSnackBar(
                                  context: context,
                                  message: file.canNotDeleteReason,
                                  color: ColorSchemes.snackBarInfo,
                                  icon: ImagePaths.info,
                                );
                              }
                            },
                            onEdit: (file) {
                              if (file.isEditable) {
                                if (file.code == QuestionsCode.image) {
                                  _bloc.add(UploadFileImageEvent(file: file));
                                } else if (file.code == QuestionsCode.file) {
                                  _bloc
                                      .add(UploadFileDocumentEvent(file: file));
                                }
                              } else {
                                showSnackBar(
                                  context: context,
                                  message: file.canNotEditReason,
                                  color: ColorSchemes.snackBarInfo,
                                  icon: ImagePaths.info,
                                );
                              }
                            },
                            onTapFile: (file) {
                              if (file.value.isEmpty) {
                                if (file.code == QuestionsCode.image) {
                                  _bloc.add(UploadFileImageEvent(file: file));
                                } else if (file.code == QuestionsCode.file) {
                                  _bloc
                                      .add(UploadFileDocumentEvent(file: file));
                                }
                              } else {
                                Navigator.pushNamed(context, Routes.wallImages,
                                    arguments: ImagesScreen(
                                      initialIndex: 0,
                                      images: [
                                        WallAttachment(attachment: file.value)
                                      ],
                                    ));
                              }
                            },
                            onAddMultiImage: (file, index) {
                              if (file.value.isNotEmpty) {
                                multiServerImages = file.value
                                    .split(",")
                                    .where((element) => isUrl(element))
                                    .toList();
                                _maxMultipleImages =
                                    file.maxCount - multiServerImages.length;
                              } else {
                                imagesAssets = [];
                                cameraImages = [];
                                _maxMultipleImages = file.maxCount;
                              }

                              _bloc.add(UploadFileImageEvent(
                                  file: file,
                                  index: index,
                                  isMultiImage: true));
                            },
                            onDeleteMultiImage: (file, index) {
                              if (file.isEditable) {
                                _showActionDialog(
                                  icon: ImagePaths.warning,
                                  text: S
                                      .of(context)
                                      .areYouSureYouWantToDeleteThisFile,
                                  primaryText: S.of(context).no,
                                  onPrimaryAction: () {
                                    _navigateBackEvent();
                                  },
                                  secondaryText: S.of(context).yes,
                                  onSecondaryAction: () {
                                    if (file.code == QuestionsCode.multiImage) {
                                      _bloc.add(DeleteFileImageEvent(
                                        files: _profile.files,
                                        file: file,
                                        index: index,
                                        isMultiImage: true,
                                      ));
                                    } else {}
                                    _navigateBackEvent();
                                  },
                                );
                              } else {
                                showSnackBar(
                                  context: context,
                                  message: file.canNotDeleteReason,
                                  color: ColorSchemes.snackBarInfo,
                                  icon: ImagePaths.info,
                                );
                              }
                            },
                            onTapMultiImage: (images, index) {
                              List<GalleryAttachment> galleryImages = [];
                              for (var image in images) {
                                galleryImages
                                    .add(GalleryAttachment(attachment: image));
                              }
                              Navigator.pushNamed(context, Routes.galleryImages,
                                  arguments: GalleryImages(
                                    initialIndex: index,
                                    images: galleryImages,
                                  ));
                            },
                            onSave: (files) {
                              _bloc.add(SaveFilesPressedEvent(files: files));
                            },
                            onChangeDate: (file) {
                              if (file.isEditable) {
                                if (Platform.isAndroid) {
                                  androidDatePicker(
                                    context: context,
                                    firstDate: DateTime(1990),
                                    onSelectDate: (date) {
                                      if (date == null) return;
                                      if (file.expireDate.trim().isNotEmpty) {
                                        if (date ==
                                            DateTime.parse(file.expireDate)) {
                                          return;
                                        }
                                      }

                                      _bloc.add(
                                        SelectFileExpireDateEvent(
                                            files: _profile.files,
                                            file: file,
                                            date: date),
                                      );
                                    },
                                    selectedDate: file.expireDate.isEmpty
                                        ? DateTime.now()
                                        : DateTime(1990).isAfter(
                                                DateTime.parse(file.expireDate))
                                            ? DateTime(1990)
                                            : DateTime.parse(file.expireDate),
                                  );
                                } else {
                                  DateTime tempDate = file.expireDate.isEmpty
                                      ? DateTime.now()
                                      : DateTime.parse(file.expireDate);
                                  iosDatePicker(
                                    context: context,
                                    selectedDate: file.expireDate.isEmpty
                                        ? DateTime.now()
                                        : DateTime(1990).isAfter(
                                                DateTime.parse(file.expireDate))
                                            ? DateTime(1990)
                                            : DateTime.parse(file.expireDate),
                                    onChange: (date) {
                                      tempDate = date;
                                    },
                                    onCancel: () {
                                      _navigateBackEvent();
                                    },
                                    onDone: () {
                                      if (file.expireDate.isEmpty) {
                                        _bloc.add(
                                          SelectFileExpireDateEvent(
                                              files: _profile.files,
                                              file: file,
                                              date: tempDate),
                                        );
                                      } else if (tempDate !=
                                              DateTime.parse(file.expireDate) ||
                                          file.expireDate.isEmpty) {
                                        _bloc.add(
                                          SelectFileExpireDateEvent(
                                              files: _profile.files,
                                              file: file,
                                              date: tempDate),
                                        );
                                      }
                                      _navigateBackEvent();
                                    },
                                  );
                                }
                              } else {
                                showSnackBar(
                                  context: context,
                                  message: file.canNotEditReason,
                                  color: ColorSchemes.snackBarInfo,
                                  icon: ImagePaths.info,
                                );
                              }
                            },
                          ),
                          FamilyWidget(
                            family: _profile.family,
                            onDelete: (familyMember) {
                              _showActionDialog(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisFamilyMember,
                                primaryText: S.of(context).no,
                                onPrimaryAction: () {
                                  _navigateBackEvent();
                                },
                                secondaryText: S.of(context).yes,
                                onSecondaryAction: () {
                                  _navigateBackEvent();
                                  _deleteFamilyMemberEvent(
                                    familyMember,
                                  );
                                },
                              );
                            },
                            onEdit: (familyMember) {
                              _addPressedEvent(
                                isUpdate: true,
                                _currentIndex,
                                familyMember: familyMember,
                              );
                            },
                          ),
                          CarsWidget(
                            cars: _profile.cars,
                            onDelete: (car) {
                              _showActionDialog(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisCar,
                                primaryText: S.of(context).no,
                                onPrimaryAction: () {
                                  _navigateBackEvent();
                                },
                                secondaryText: S.of(context).yes,
                                onSecondaryAction: () {
                                  _navigateBackEvent();
                                  _deleteCarEvent(
                                    _profile.cars,
                                    car,
                                  );
                                },
                              );
                            },
                            onEdit: (car) {
                              _addPressedEvent(
                                _currentIndex,
                                car: car,
                              );
                            },
                          ),
                        ],
                        onTapStep: (int index) {
                          FocusScope.of(context).unfocus();
                          _onTabStepEvent(index);
                        },
                        currentIndex: _currentIndex,
                        pageController: _pageController,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void _animateTo(GlobalKey? key) {
    Scrollable.ensureVisible(
      key?.currentContext ?? context,
      duration: const Duration(milliseconds: 500),
      alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      curve: Curves.easeInOut,
    );
  }

  Widget _buildAddWidget(int page) {
    return ((page == 4 && _profile.unit.userType.code != "3") || page == 5)
        ? InkWell(
            onTap: () {
              _addPressedEvent(
                _currentIndex,
              );
            },
            child: Container(
              width: 48,
              height: 48,
              margin: const EdgeInsetsDirectional.only(end: 16, bottom: 16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSchemes.black,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 32,
                    spreadRadius: 0,
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  ImagePaths.add,
                  fit: BoxFit.contain,
                  color: ColorSchemes.white,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  /* Events */
  void _onTabStepEvent(int index) {
    _bloc.add(StepPressedEvent(index: index));
  }

  void _cameraPressedEvent({
    ProfileFile? file,
    List<PageField>? questions,
    PageField? question,
    int index = -1,
  }) {
    _bloc.add(CameraPressedEvent(
      file: file,
      questions: questions,
      question: question,
      index: index,
    ));
  }

  void _galleryPressedEvent({
    ProfileFile? file,
    List<PageField>? questions,
    PageField? question,
    int index = -1,
    bool isMultiImage = false,
  }) {
    _bloc.add(GalleryPressedEvent(
      file: file,
      questions: questions,
      question: question,
      index: index,
      isMultiImage: isMultiImage,
    ));
  }

  void _openMediaBottomSheetEvent() {
    _bloc.add(UploadProfileImagePressedEvent());
  }

  void _askForCameraPermissionEvent(
    Function() onTab, {
    Permission permission = Permission.camera,
  }) {
    _bloc.add(
      AskForCameraPermissionEvent(
        onTab: () {
          onTab();
        },
        permission: permission,
      ),
    );
  }

  void _askForStoragePermissionEvent(ProfileFile file) {
    _bloc.add(AskForStoragePermissionEvent(file: file));
  }

  void _selectImageEvent(String imagePath) {
    _bloc.add(SelectImageEvent(imagePath: imagePath));
  }

  void _addPressedEvent(int page,
      {bool? isUpdate, FamilyMember? familyMember, Car? car}) {
    _bloc.add(AddPressedEvent(
        isUpdate: isUpdate ?? false,
        page: _currentIndex,
        familyMember: familyMember,
        car: car));
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  void _addUserUnitCarEvent(List<Car> cars) =>
      _bloc.add(AddUserUnitCarEvent(cars));

  void _updateUserUnitCarEvent(List<Car> cars) =>
      _bloc.add(UpdateUserUnitCarEvent(cars));

  /* End Events */

  /* Helper Methods */
  void _changeCurrentStep(int index) {
    _currentIndex = index;
    _pageController.animateToPage(
      _currentIndex - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateBack() {
    Navigator.pop(context);
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    showActionDialogWidget(
      context: context,
      text: text,
      primaryText: primaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryText: secondaryText,
      secondaryAction: () {
        onSecondaryAction();
      },
      icon: icon,
    );
  }

  void _showMessageDialog(
    String message,
    String icon,
    Function() onTap,
  ) {
    showMassageDialogWidget(
      context: context,
      icon: icon,
      text: message,
      buttonText: S.of(context).ok,
      onTap: () {
        onTap();
      },
    );
  }

  Future<void> _getImage(
    ImageSource imageSource, {
    ProfileFile? file,
    List<PageField>? questions,
    PageField? question,
    int index = -1,
    bool isMultiImage = false,
  }) async {
    if (isMultiImage) {
      List<AssetEntity>? images = [];
      images = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          selectedAssets: imagesAssets,
          maxAssets: _maxMultipleImages - selectedMultiImagesCount,
          requestType: RequestType.image,
          specialPickerType: SpecialPickerType.noPreview,
        ),
      );

      if (images != null && images.isNotEmpty) {
        imagesAssets = images;
      } else {
        return;
      }
      List<File> imagesList = [];

      await convertAssetEntitiesToFiles(imagesAssets).then((value) {
        imagesList = value;
      });

      for (int i = 0; i < cameraImages.length; i++) {
        if (!imagesList.contains(cameraImages[i])) {
          imagesList.add(cameraImages[i]);
        }
      }

      if (file != null) {
        file = file.copyWith(value: "");
        file = file.copyWith(
            value: multiServerImages.map((e) => e ?? "").join(","));
        if (file.value.isEmpty) {
          file = file.copyWith(
              value: imagesList.map((e) => e.path ?? "").join(","));
        } else {
          file = file.copyWith(
              value:
                  "${file.value},${imagesList.map((e) => e.path ?? "").join(",")}");
        }
      }
      _bloc.add(SelectMultiImageEvent(
        files: _profile.files,
        file: file!,
        index: index,
      ));
    } else {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: imageSource);
      XFile? imageFile = await compressFile(File(pickedFile!.path));
      if (imageFile == null) {
        return;
      }

      if (file != null) {
        if (file.code == QuestionsCode.multiImage) {
          cameraImages.add(File(imageFile.path));
          if (file.value.isEmpty) {
            file = file.copyWith(value: imageFile.path ?? "");
          } else {
            file =
                file.copyWith(value: "${file.value},${imageFile.path ?? ""}");
          }
          selectedMultiImagesCount++;
        } else {
          file = file.copyWith(value: imageFile.path ?? "");
        }

        _bloc.add(SelectFileImageEvent(
          files: _profile.files,
          file: file,
          index: index,
        ));
      } else if (questions != null && question != null) {
        _bloc.add(SelectQuestionImageEvent(
          questions: questions,
          question: question,
          imagePath: imageFile.path,
        ));
      } else {
        _selectImageEvent(imageFile.path);
      }
    }
  }

  Future<void> _getFile(ProfileFile file) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    file = file.copyWith(value: result.files.single.path ?? "");
    _bloc.add(SelectFileDocumentEvent(files: _profile.files, file: file));
  }

  void _askForCameraPermission(Function() onTab,
      {Permission permission = Permission.camera}) async {
    bool cameraPermission = await PermissionServiceHandler()
        .handleServicePermission(setting: permission);
    if (cameraPermission) {
      onTab();
    } else {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () async {
          _navigateBackEvent();
          openAppSettings().then((value) {
            // _askForCameraPermissionEvent(onTab);
            if (value == true) {
              onTab();
            }
          });
        },
        onSecondaryAction: () {
          _navigateBackEvent();
        },
        primaryText: S.of(context).ok,
        secondaryText: S.of(context).cancel,
        text: permission == Permission.camera
            ? S.of(context).youShouldHaveCameraPermission
            : S.of(context).youShouldHaveStoragePermission,
      );
    }
  }

  void _deleteFamilyMemberEvent(FamilyMember familyMember) {
    _bloc.add(DeleteFamilyMemberEvent(
      familyMember: familyMember,
    ));
  }

  void _deleteCarEvent(List<Car> cars, Car car) {
    _bloc.add(DeleteCarEvent(cars: cars, car: car));
  }

  void _askForStoragePermission(ProfileFile file) async {
    bool storagePermission =
        await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getStorageFilesPermission(
      androidDeviceInfo:
          Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
    ));
    if (storagePermission) {
      _getFile(file);
    } else {
      _showActionDialog(
        icon: ImagePaths.warning,
        onPrimaryAction: () async {
          _navigateBackEvent();
          openAppSettings().then((value) {
            _askForStoragePermissionEvent(file);
          });
        },
        onSecondaryAction: () {
          _navigateBackEvent();
        },
        primaryText: S.of(context).ok,
        secondaryText: S.of(context).cancel,
        text: S.of(context).youShouldHaveStoragePermission,
      );
    }
  }

  void _updateProfileUnitRequest({required ProfileUnit unit}) {
    UpdateUserUnitRequest request = UpdateUserUnitRequest(
        id: unit.userUnitId, gazNo: unit.gasNumber, telephone: unit.telephone);

    _bloc.add(UpdateProfileUnitEvent(request: request));
  }

  void _openSearchableBottomSheet(
      List<PageField> questions, PageField question, bool isMultiChoice) {
    showSearchableBottomSheet(
      context: context,
      pageField: question,
      isMultiChoice: isMultiChoice,
      onSaveMultiChoice: (pageField, choices) {
        _bloc.add(UpdateSearchableMultiQuestionEvent(
            questions: questions, question: pageField, answer: choices));
      },
      onChoicesSelected: (pageField, choice) {
        _bloc.add(UpdateSearchableSingleQuestionEvent(
            questions: questions, question: pageField, answer: choice));
        _navigateBackEvent();
      },
    );
  }
/* End Helper Methods */
}
