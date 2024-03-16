import 'dart:io';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/convert_asset_entities_to_files.dart';
import 'package:city_eye/src/core/utils/convert_assets_to_files.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/is_keyboard_open.dart';
import 'package:city_eye/src/core/utils/page_keys.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/local/singleton/register/register_singleton.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_code_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/steps/steps.dart';
import 'package:city_eye/src/presentation/blocs/register/register_bloc.dart';
import 'package:city_eye/src/presentation/screens/register/skeleton/register_skeleton.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/compound_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/documents_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/footer_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/header_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/profile_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/units_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/steps_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class RegisterScreen extends BaseStatefulWidget {
  const RegisterScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen> {
  List<PageField> _documents = [];

  RegisterBloc get _bloc => BlocProvider.of<RegisterBloc>(context);
  final TextEditingController _compoundNameController = TextEditingController();
  final TextEditingController _unitNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<LookupFile> _userTypes = [];
  String? _compoundNameErrorMessage;
  String? _unitNoErrorMessage;
  String? _fullNameErrorMessage;
  String? _emailAddressErrorMessage;
  String? _mobileNumberErrorMessage;
  String? _passwordErrorMessage;
  late PageController _pageController;
  CompoundUnit _selectedUnit = const CompoundUnit(id: -1, name: '', units: []);
  CompoundUnit _unitNumber = const CompoundUnit(id: 0, name: '', units: []);
  Compound _compound = const Compound(
    id: -1,
    name: "",
    logo: "",
  );
  int _userTypeId = 0;
  int _currentIndex = 1;
  int pageId = 1;
  final RegisterSingleton _registerSingleton = RegisterSingleton();
  final ScrollController scrollController = ScrollController();

  bool _isImagesRequired = false;

  int _maxMultipleImages = 0;
  int selectedMultiImagesCount = 0;
  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];
  String _countryCode = "EG";

  @override
  void initState() {
    _bloc.add(GetUserTypesEvent());
    _pageController = PageController(initialPage: _currentIndex - 1);
    _compoundNameController.text = _registerSingleton.getCompound().name ?? "";
    _compound = _registerSingleton.getCompound();
    _unitNumberController.text = _registerSingleton.getUnit().name ?? "";
    _selectedUnit = _registerSingleton.getUnit();
    _unitNumber = _registerSingleton.getUnit();
    _userTypeId = _registerSingleton.getRegisterType();
    _fullNameController.text = _registerSingleton.getFullName();
    _emailAddressController.text = _registerSingleton.getEmailAddress();
    _mobileNumberController.text = _registerSingleton.getMobileNumber();
    _countryCode = _registerSingleton.getCountryCode();
    _documents = _registerSingleton.getDocuments();
    _bloc.documents = _documents;
    super.initState();
  }

  @override
  void dispose() {
    if (_unitNumberController.text.isEmpty &&
        _registerSingleton.getUnit().id != -1) {
      _registerSingleton
          .setUnit(const CompoundUnit(id: -1, name: '', units: []));
    }
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
      if (state is ShowLoadingState) {
        showLoading();
      } else if (state is HideLoadingState) {
        hideLoading();
      } else if (state is GetDocumentsPageSuccessState) {
        _documents = state.fields;
      } else if (state is GetDocumentsPageErrorState) {
      } else if (state is NavigateToLoginScreenState) {
        _registerSingleton.setDocuments(state.documents);
        Navigator.pushReplacementNamed(context, Routes.signIn, arguments: {
          "unitId": -1,
        });
      } else if (state is NavigationPopState) {
        Navigator.pop(context);
      } else if (state is NavigateToSelectCompoundScreenState) {
        selectedMultiImagesCount = 0;
        cameraImages = [];
        imagesAssets = [];
        _isImagesRequired = false;
        _navigateToCompoundScreenState();
      } else if (state is OpenUnitNumberBottomSheetState) {
        _openUnitNumberBottomSheetState(
          compoundId: _compound.id,
          userTypeId: _userTypeId,
        );
      } else if (state is CompoundNameEmptyFormatState) {
        _compoundNameErrorMessage = state.compoundNameValidatorMessage;
      } else if (state is UnitNumberEmptyFormatState) {
        _unitNoErrorMessage = state.unitNumberValidatorMessage;
      } else if (state is TypeEmptyFormatState) {
      } else if (state is FullNameEmptyFormatState) {
        _fullNameErrorMessage = state.fullNameValidatorMessage;
      } else if (state is EmailAddressEmptyFormatState) {
        _emailAddressErrorMessage = state.emailAddressValidatorMessage;
      } else if (state is EmailNotValidState) {
        _emailAddressErrorMessage = state.emailValidatorMessage;
      } else if (state is MobileNumberEmptyFormatState) {
        _mobileNumberErrorMessage = state.mobileNumberValidatorMessage;
      } else if (state is EmailAddressFormatValidState) {
        _emailAddressErrorMessage = null;
      } else if (state is FullNameFormatValidState) {
        _fullNameErrorMessage = null;
      } else if (state is UnitNumberFormatValidState) {
        _unitNoErrorMessage = null;
      } else if (state is CompoundNameFormatValidState) {
        _compoundNameErrorMessage = null;
      } else if (state is MobileNumberFormatValidState) {
        _mobileNumberErrorMessage = null;
      } else if (state is TypeFormatValidState) {
      } else if (state is CompoundSaveAndContinueValidState) {
        _compoundNameErrorMessage = null;
        _unitNoErrorMessage = null;
        _bloc.add(OnTapStepEvent(id: state.nextPageId));
      } else if (state is ProfileSaveAndContinueValidState) {
        _fullNameErrorMessage = null;
        _mobileNumberErrorMessage = null;
        _emailAddressErrorMessage = null;
        _passwordErrorMessage = null;
        if (_documents.isEmpty) {
          _onSaveDocumentsEvent();
        } else {
          _bloc.add(OnTapStepEvent(id: state.nextPageId));
          _bloc.add(GetDocumentsEvent());
        }
      } else if (state is ValidateMobileNumberWithApiErrorState) {
        showMassageDialogWidget(
            context: context,
            text: state.errorMessage,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              Navigator.pop(context);
            });
      } else if (state is GetUserTypesSuccessState) {
        _userTypes = state.userTypes;
        _userTypeId = _registerSingleton.getRegisterType() == -1
            ? _userTypes.first.id
            : _registerSingleton.getRegisterType();
        bool isSelected = false;
        for (int i = 0; i < _userTypes.length; i++) {
          if (_userTypes[i].id == _userTypeId) {
            _userTypes[i] = _userTypes[i].copyWith(isSelected: true);
            isSelected = true;
          } else {
            _userTypes[i] = _userTypes[i].copyWith(isSelected: false);
          }
        }

        if (!isSelected) {
          _userTypes[0] = _userTypes[0].copyWith(isSelected: true);
          _userTypeId = _userTypes[0].id;
        }
        if (_compound.id != -1) {
          _bloc.add(GetDocumentsPageEvent(
              pageFieldsRequest: PageFieldsRequest(
            compoundId: _compound.id,
            userTypeId: _userTypeId,
            generalExtrafield: [
              const PageCodeRequest(pageCode: PageKeys.userFile),
            ],
          )));
        }
      } else if (state is GetUserTypesErrorState) {
        showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              Navigator.pop(context);
            });
      } else if (state is OnSelectTypeState) {
        _userTypes = state.userType;
        _userTypeId = state.id;
        _registerSingleton.setRegisterType(_userTypeId);
        _unitNumberController.text = "";
        _selectedUnit = CompoundUnit();
        _unitNumber = CompoundUnit();
        _registerSingleton.setUnit(CompoundUnit());
        if (_compound.id != 0) {
          _bloc.add(GetDocumentsPageEvent(
              pageFieldsRequest: PageFieldsRequest(
            compoundId: _compound.id,
            userTypeId: _userTypeId,
            generalExtrafield: [
              const PageCodeRequest(pageCode: PageKeys.userFile),
            ],
          )));
        }
      } else if (state is OnTapDocumentImageState) {
        _uploadMediaBottomSheet(document: state.document);
      } else if (state is OnTapDocumentFileState) {
        _pickPDFFile(document: state.document);
      } else if (state is OpenCameraState) {
        _imagePiker(
          source: ImageSource.camera,
          document: state.document,
        );
      } else if (state is OpenGalleryState) {
        _imagePiker(
          source: ImageSource.gallery,
          document: state.document,
        );
      } else if (state is OnTapStepState) {
        _currentIndex = state.id;
        _pageController.jumpToPage(_currentIndex - 1);
      } else if (state is SelectImageState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
      } else if (state is SelectFileState) {
        _bloc.add(ValidationFileEvent(
          document: state.document,
        ));
      } else if (state is DocumentsSaveAndContinueState) {
        showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.success,
            buttonText: S.of(context).ok,
            onTap: () {
              Navigator.pop(context);
              _registerSingleton.clearAllData();
              for (var element in _documents) {
                element = element.copyWith(value: "", imagesList: []);
                imagesAssets.clear();
                if (element.typeId == 3) {
                  element.imagesList.clear();
                }
              }
              for (int i = 0; i < _userTypes.length; i++) {
                if (i == 0) {
                  _userTypes[i] = _userTypes[i].copyWith(isSelected: true);
                } else {
                  _userTypes[i] = _userTypes[i].copyWith(isSelected: false);
                }
              }
              _bloc.add(NavigateToOTPScreenEvent(
                phoneNumber: _mobileNumberController.text.toString().trim(),
                userId: state.userId,
                otp: state.otp,
              ));
            });
      } else if (state is NavigateToOTPScreenState) {
        Navigator.pushReplacementNamed(context, Routes.otp, arguments: {
          "phoneNumber": state.phoneNumber,
          "userId": state.userId,
          "invitationId": 0,
          "otp": state.otp,
          "compoundID": _compound.id,
        });
      } else if (state is DeleteFileState) {
        Navigator.pop(context);
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
      } else if (state is FileValidState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
      } else if (state is FileNotValidState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
      } else if (state is FieldValidationFileState) {
      } else if (state is DeleteImageState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
        Navigator.pop(context);
      } else if (state is GetDocumentsSuccessState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
      } else if (state is DocumentsNotValidState) {
        _documents = state.documents;
        for (var element in _documents) {
          if (element.errorMessage.isNotEmpty) {
            _scrollToElementKey(element.key!);
            break;
          }
        }
        _isImagesRequired = true;
      } else if (state is AddMultipleImageState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
        _isImagesRequired = true;
      } else if (state is DeleteMultipleImageState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
        _isImagesRequired = true;

        if (state.isMultiImage && state.index != -1) {
          if (state.index < imagesAssets.length) {
            imagesAssets.removeAt(state.index);
          } else {
            cameraImages.removeAt(state.index - imagesAssets.length);
            selectedMultiImagesCount--;
          }
        }
      } else if (state is SelectMultipleImageState) {
        _documents = state.documents;
        _registerSingleton.setDocuments(state.documents);
        _isImagesRequired = true;
      } else if (state is PasswordEmptyState) {
        _passwordErrorMessage = state.passwordValidatorMessage;
      } else if (state is PasswordNotValidState) {
        _passwordErrorMessage = state.passwordValidatorMessage;
      } else if (state is PasswordFormatValidState) {
        _passwordErrorMessage = null;
      } else if (state is RegisterErrorState) {
        showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              Navigator.pop(context);
            });
      }
    }, builder: (context, state) {
      return Scaffold(
        body: state is ShowSkeletonState
            ? const RegisterSkeleton()
            : Column(
                children: [
                  HeaderWidget(
                    title: S.of(context).createYourAccount,
                    hasBackButton: _currentIndex >= 2,
                    backButtonAction: () {
                      _onTapStep(_currentIndex - 1);
                    },
                  ),
                  StepsWidget(
                    steps: [
                      Steps(id: 1, name: S.of(context).property),
                      Steps(id: 2, name: S.of(context).createProfile),
                      if (_documents.isNotEmpty)
                        Steps(id: 3, name: S.of(context).identity),
                    ],
                    pages: [
                      CompoundWidget(
                        compoundNameController: _compoundNameController,
                        unitNoController: _unitNumberController,
                        userTypes: _userTypes,
                        compoundNameErrorMessage: _compoundNameErrorMessage,
                        unitNoErrorMessage: _unitNoErrorMessage,
                        onTapCompound: () => _bloc.add(
                          NavigateToSelectCompoundScreenEvent(),
                        ),
                        onTapUnitNo: () {
                          _bloc.add(
                            OpenUnitNumberBottomSheetEvent(
                              compoundId: _compound.id,
                            ),
                          );
                        },
                        onSelectType: (int id) {
                          _bloc.add(SelectTypeEvent(
                            id: id,
                          ));
                        },
                      ),
                      ProfileWidget(
                        passwordController: _passwordController,
                        fullNameController: _fullNameController,
                        emailAddressController: _emailAddressController,
                        mobileNumberController: _mobileNumberController,
                        fullNameErrorMessage: _fullNameErrorMessage,
                        emailAddressErrorMessage: _emailAddressErrorMessage,
                        mobileNumberErrorMessage: _mobileNumberErrorMessage,
                        passwordErrorMessage: _passwordErrorMessage,
                        countryCode: _countryCode,
                        onChangeFullName: (String value) {
                          _registerSingleton.setFullName(value);
                          _bloc.add(
                            ValidateFullNameEvent(fullName: value),
                          );
                        },
                        onChangeEmailAddress: (String value) {
                          _registerSingleton.setEmailAddress(value);
                          _bloc.add(
                            ValidateEmailAddressEvent(
                              emailAddress: value,
                            ),
                          );
                        },
                        onChangeMobileNumber: (number, code) {
                          _registerSingleton.setMobileNumber(number);
                          _registerSingleton.setCountryCode(code);
                          _countryCode = code;
                          _bloc.add(
                            ValidateMobileNumberEvent(
                              mobileNumber: number,
                              regionCode: code,
                            ),
                          );
                        },
                        onChangePassword: (String value) {
                          // _registerSingleton.setMobileNumber(value);
                          _bloc.add(ValidatePasswordEvent(password: value));
                        },
                      ),
                      if (_documents.isNotEmpty)
                        DocumentsWidget(
                          documents: _registerSingleton.getDocuments(),
                          isImagesRequired: _isImagesRequired,
                          onTapImage: (PageField document) {
                            _bloc.add(
                                OnTapDocumentImageEvent(document: document));
                          },
                          onTapFile: (PageField document) {
                            _bloc.add(
                                OnTapDocumentFileEvent(document: document));
                          },
                          deleteFileAction: (PageField document) {
                            _dialogMessage(
                                icon: ImagePaths.warning,
                                message: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisFile,
                                primaryAction: () {
                                  _bloc
                                      .add(DeleteFileEvent(document: document));
                                });
                          },
                          deleteImageAction: (PageField document) {
                            _dialogMessage(
                                icon: ImagePaths.warning,
                                message: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisImage,
                                primaryAction: () {
                                  _bloc.add(
                                      DeleteImageEvent(document: document));
                                });
                          },
                          onAddMultipleImageTap: (document, min, max) {
                            _maxMultipleImages = max;
                            _onOpenMediaBottomSheet(document, true);
                          },
                          onDeleteMultipleImageTap: (document, mIndex) {
                            _dialogMessage(
                                icon: ImagePaths.warning,
                                message: S
                                    .of(context)
                                    .areYouSureYouWantToDeleteThisImage,
                                primaryAction: () {
                                  _navigateBack();
                                  _bloc.add(DeleteMultipleImageEvent(
                                      document: document, index: mIndex));
                                });
                          },
                          // maxMultipleImages: _maxMultipleImages,
                          // minMultipleImages: _minMultipleImages,
                          scrollController: scrollController,
                        )
                    ],
                    onTapStep: (int currentIndex) {
                      _onTapStep(currentIndex);
                    },
                    currentIndex: _currentIndex,
                    pageController: _pageController,
                  ),
                  if (!isKeyboardOpen(context))
                    FooterWidget(
                      loginAction: () {
                        _bloc.add(
                          NavigateToLoginScreenEvent(),
                        );
                      },
                      onTapCompoundSaveContinueAction: (int currentIndex) {
                        _bloc.add(CompoundSaveAndContinueEvent(
                          compoundName: _compoundNameController.text,
                          unitNumber: _unitNumberController.text,
                          nextPageId: currentIndex,
                        ));
                      },
                      onTapProfileSaveContinueAction: (int currentIndex) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _bloc.add(ProfileSaveAndContinueEvent(
                          fullName: _fullNameController.text,
                          mobileNumber: _mobileNumberController.text,
                          countryCode: _countryCode,
                          emailAddress: _emailAddressController.text,
                          nextPageId: currentIndex,
                          password: _passwordController.text,
                          documents: _documents,
                        ));
                      },
                      onTapDocumentsSaveContinueAction:
                          (int currentIndex) async {
                        _onSaveDocumentsEvent();
                      },
                      currentIndex: _currentIndex,
                    )
                ],
              ),
      );
    });
  }

  void _onSaveDocumentsEvent() {
    RegisterRequest request = RegisterRequest(
      unitId: _unitNumber.id.toString(),
      userTypeId: _userTypeId.toString(),
      name: _fullNameController.text.toString().trim(),
      email: _emailAddressController.text.toString().trim(),
      mobileNumber: _mobileNumberController.text.toString().trim(),
      password: _passwordController.text.toString().trim(),
      files: _documents.mapToDomain(),
    );

    _bloc.add(DocumentsSaveAndContinueEvent(
      documents: _documents,
      request: request,
    ));
  }

  void _onOpenMediaBottomSheet(PageField document, [bool isMultiple = false]) {
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _navigateBack();
        if (await PermissionServiceHandler().handleServicePermission(
          setting: PermissionServiceHandler.getCameraPermission(),
        )) {
          _getImage(document, ImageSource.camera);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBack();
              openAppSettings().then((value) async {
                // if (await PermissionServiceHandler()
                //     .handleServicePermission(setting: Permission.camera)) {}
              });
            },
            onSecondaryAction: () {
              _navigateBack();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveCameraPermission,
          );
        }
      },
      onTapGallery: () async {
        _navigateBack();
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getGalleryPermission(
          isMultiple,
          androidDeviceInfo:
              Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
        ))) {
          _getImage(document, ImageSource.gallery, isMultiple);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBack();
              openAppSettings().then((value) async {
                // if (await PermissionServiceHandler().handleServicePermission(
                //   setting: Permission.storage,
                // )) {}
              });
            },
            onSecondaryAction: () {
              _navigateBack();
            },
            primaryText: S.of(context).ok,
            secondaryText: S.of(context).cancel,
            text: S.of(context).youShouldHaveStoragePermission,
          );
        }
      },
    );
  }

  Future<void> _getImage(
    PageField document,
    ImageSource img, [
    bool isMultiple = false,
  ]) async {
    final ImagePicker picker = ImagePicker();
    if (isMultiple) {
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

      if (images != null) {
        imagesAssets = images;
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

      if (document.imagesList.isEmpty) {
        document = document.copyWith(imagesList: imagesList);
      } else {
        document = document.copyWith(
          imagesList: [],
        );
        document =
            document.copyWith(imagesList: document.imagesList + imagesList);
      }
      _bloc.add(
          SelectMultipleImageEvent(document: document, images: imagesList));
    } else {
      final pickedFile = await picker.pickImage(
        source: img,
      );
      if (pickedFile != null) {
        XFile? imageFile = await compressFile(File(pickedFile.path));
        cameraImages.add(File(imageFile!.path));
        selectedMultiImagesCount++;
        _bloc.add(AddMultipleImageEvent(document: document, image: imageFile));
      }
    }
  }

  Future _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    return showActionDialogWidget(
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

  void _navigateBack() {
    Navigator.pop(context);
  }

  void _onTapStep(int newIndex) {
    if (newIndex == 1) {
      _bloc.add(OnTapStepEvent(
        id: newIndex,
      ));
    } else if (newIndex == 2) {
      _bloc.add(CompoundSaveAndContinueEvent(
        compoundName: _compoundNameController.text,
        unitNumber: _unitNumberController.text,
        nextPageId: 2,
      ));
    } else if (newIndex == 3) {
      if (_compoundNameController.text.isNotEmpty &&
          _unitNumberController.text.isNotEmpty &&
          _currentIndex == 2) {
        FocusManager.instance.primaryFocus?.unfocus();
        _bloc.add(ProfileSaveAndContinueEvent(
          fullName: _fullNameController.text,
          mobileNumber: _mobileNumberController.text,
          countryCode: _countryCode,
          emailAddress: _emailAddressController.text,
          nextPageId: 3,
          password: _passwordController.text,
          documents: _documents,
        ));
      }
    }
  }

  void _openUnitNumberBottomSheetState({
    required int compoundId,
    required int userTypeId,
  }) {
    showBottomSheetWidget(
      height: MediaQuery.sizeOf(context).height / 1.5,
      context: context,
      content: UnitsBottomSheetWidget(
        compoundId: compoundId,
        userTypeId: userTypeId,
        selectedUnit: _selectedUnit,
        userId: -1,
      ),
      titleLabel: S.of(context).selectUnit,
    ).then((value) {
      if (value != null) {
        print(value['unitName']);
        _selectedUnit = value['selectedUnit'];
        _unitNumber = value['selectedUnit'];
        _unitNumberController.text = value['unitName'];
        _bloc.add(ValidateUnitNumberEvent(
          unitNumber: value['unitName'],
        ));
        _registerSingleton.setUnit(CompoundUnit(
            id: _unitNumber.id,
            name: value['unitName'],
            units: _unitNumber.units));
      }
    });
  }

  void _navigateToCompoundScreenState() {
    Navigator.pushNamed(
      context,
      Routes.compound,
      arguments: _compound,
    ).then((value) {
      Compound compound = const Compound();
      compound = _compound;
      _compound = value as Compound;
      _registerSingleton.setCompound(_compound);
      if (compound.id != _compound.id) {
        _unitNumberController.text = '';
        _compoundNameController.text = _compound.name;
        _bloc.add(ValidateCompoundNameEvent(
          compoundName: _compound.name,
        ));
        _bloc.add(GetDocumentsEvent());
        for (var element in _documents) {
          element = element.copyWith(value: '');
        }
      }
      _bloc.add(GetDocumentsPageEvent(
          pageFieldsRequest: PageFieldsRequest(
        compoundId: _compound.id,
        userTypeId: _userTypeId,
        generalExtrafield: [
          const PageCodeRequest(pageCode: PageKeys.userFile),
        ],
      )));
    });
  }

  void _uploadMediaBottomSheet({
    required PageField document,
  }) {
    showBottomSheetUploadMedia(
        context: context,
        onTapCamera: () {
          _cameraAndGalleryPermission(
              context: context, isCamera: true, document: document);
        },
        onTapGallery: () {
          _cameraAndGalleryPermission(
              context: context, isCamera: false, document: document);
        });
  }

  void _imagePiker({
    required ImageSource source,
    required PageField document,
  }) async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: source).then((value) async {
      if (value != null) {
        final String filePath = value.path;
        XFile? imageFile = await compressFile(File(filePath));
        _bloc.add(SelectImageEvent(
          xFile: imageFile!,
          document: document,
        ));
      }
    });
  }

  Future<void> _pickPDFFile({
    required PageField document,
  }) async {
    if (await PermissionServiceHandler().handleServicePermission(
        setting: PermissionServiceHandler.getStorageFilesPermission(
      androidDeviceInfo:
          Platform.isAndroid ? await DeviceInfoPlugin().androidInfo : null,
    ))) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        final String filePath = result.files.single.path!;
        XFile? imageFile = XFile(filePath);
        _bloc.add(SelectFileEvent(
          document: document,
          file: imageFile.path,
        ));
      }
    } else {
      _dialogMessage(
          icon: ImagePaths.warning,
          message: S.of(context).storagePermissionIsRequiredToProceed,
          primaryAction: () async {
            Navigator.pop(context);
            openAppSettings().then((value) async {
              // if (await PermissionServiceHandler()
              //     .handleServicePermission(setting: Permission.storage)) {}
            });
          });
    }
  }

  void _cameraAndGalleryPermission(
      {required BuildContext context,
      required bool isCamera,
      required PageField document}) async {
    Navigator.of(context).pop();
    if (await PermissionServiceHandler().handleServicePermission(
        setting: isCamera
            ? PermissionServiceHandler.getCameraPermission()
            : PermissionServiceHandler.getSingleImageGalleryPermission())) {
      isCamera
          ? _bloc.add(OpenCameraEvent(document: document))
          : _bloc.add(OpenGalleryEvent(document: document));
    } else {
      _dialogMessage(
          icon: ImagePaths.warning,
          message: isCamera
              ? S.of(context).cameraPermissionIsRequiredToProceed
              : Platform.isAndroid
                  ? S.of(context).cameraPermissionIsRequiredToProceed
                  : S.of(context).storagePermissionIsRequiredToProceed,
          primaryAction: () async {
            Navigator.pop(context);
            openAppSettings().then((value) async {
              // if (await PermissionServiceHandler()
              //     .handleServicePermission(setting: Permission.camera)) {}
            });
          });
    }
  }

  void _dialogMessage({
    required String message,
    required String icon,
    required Function() primaryAction,
    Function()? secondaryAction,
  }) {
    showActionDialogWidget(
        context: context,
        text: message,
        icon: icon,
        primaryText: S.of(context).yes,
        secondaryText: S.of(context).no,
        primaryAction: () async {
          primaryAction();
        },
        secondaryAction: () {
          secondaryAction ?? Navigator.pop(context);
        });
  }

  Future<void> _scrollToElementKey(GlobalKey<State<StatefulWidget>> key) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Scrollable.ensureVisible(key.currentContext ?? context);
  }
}
