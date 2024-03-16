import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/convert_asset_entities_to_files.dart';
import 'package:city_eye/src/core/utils/page_keys.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/request/register_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_code_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/compound_unit.dart';
import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/steps/steps.dart';
import 'package:city_eye/src/presentation/blocs/add_unit/add_unit_bloc.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/compound_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/documents_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/header_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/units_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:city_eye/src/presentation/widgets/steps_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AddUnitScreen extends BaseStatefulWidget {
  final int userId;

  const AddUnitScreen({
    this.userId = -1,
    Key? key,
  }) : super(key: key);

  @override
  BaseState<AddUnitScreen> baseCreateState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends BaseState<AddUnitScreen> {
  AddUnitBloc get _bloc => BlocProvider.of<AddUnitBloc>(context);
  final TextEditingController _compoundNameController = TextEditingController();
  final TextEditingController _unitNumberController = TextEditingController();
  late PageController _pageController;
  final ScrollController scrollController = ScrollController();

  String? _compoundNameErrorMessage;
  String? _unitNoErrorMessage;

  int _currentIndex = 1;
  CompoundUnit _selectedUnit = const CompoundUnit(id: -1, name: '', units: []);
  CompoundUnit _unitNumber = const CompoundUnit(id: 0, name: '', units: []);
  Compound _compound = const Compound(
    id: -1,
    name: "",
    logo: "",
  );
  List<LookupFile> _userTypes = [];
  List<PageField> _documents = [];
  int _userTypeId = 0;

  int _maxMultipleImages = 5;
  int _minMultipleImages = 2;
  int selectedMultiImagesCount = 0;
  bool _isImagesRequired = false;
  final _picker = ImagePicker();

  List<AssetEntity> imagesAssets = [];
  List<File> cameraImages = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetUserTypesEvent());
    _pageController = PageController(initialPage: _currentIndex - 1);
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<AddUnitBloc, AddUnitState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetDocumentsPageSuccessState) {
          _documents = state.fields;
        } else if (state is GetDocumentsPageErrorState) {
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
          _userTypeId = _userTypes.first.id;
        } else if (state is GetUserTypesErrorState) {
          showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.error,
              buttonText: S.of(context).ok,
              onTap: () {
                Navigator.pop(context);
              });
        } else if (state is NavigateToSelectCompoundScreenState) {
          _navigateToCompoundScreenState();
        } else if (state is CompoundNameEmptyFormatState) {
          _compoundNameErrorMessage = state.compoundNameValidatorMessage;
        } else if (state is CompoundNameFormatValidState) {
          _compoundNameErrorMessage = null;
        } else if (state is OnSelectTypeState) {
          _userTypes = state.userType;
          _userTypeId = state.id;
          _selectedUnit = CompoundUnit(
            id: -1,
            name: '',
            units: [],
          );
          _unitNumber = CompoundUnit(
            id: -1,
            name: '',
            units: [],
          );
          _unitNumberController.text = "";
        } else if (state is OnTapDocumentImageState) {
          _uploadMediaBottomSheet(document: state.document);
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
        } else if (state is SelectImageState) {
          _documents = state.documents;
        } else if (state is OnTapDocumentFileState) {
          _pickPDFFile(document: state.document);
        } else if (state is SelectFileState) {
          _bloc.add(ValidationFileEvent(
            document: state.document,
          ));
        } else if (state is FileValidState) {
          _documents = state.documents;
        } else if (state is FileNotValidState) {
          _documents = state.documents;
        } else if (state is FieldValidationFileState) {
        } else if (state is DeleteFileState) {
          Navigator.pop(context);
          _documents = state.documents;
        } else if (state is DeleteImageState) {
          _documents = state.documents;
          Navigator.pop(context);
        } else if (state is DeleteMultipleImageState) {
          _documents = state.documents;
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
          _isImagesRequired = true;
        } else if (state is AddMultipleImageState) {
          _documents = state.documents;
          _isImagesRequired = true;
        } else if (state is OpenUnitNumberBottomSheetState) {
          _openUnitNumberBottomSheetState(
            compoundId: _compound.id,
            userTypeId: _userTypeId,
          );
        } else if (state is UnitNumberEmptyFormatState) {
          _unitNoErrorMessage = state.unitNumberValidatorMessage;
        } else if (state is UnitNumberFormatValidState) {
          _unitNoErrorMessage = null;
        } else if (state is CompoundSaveAndContinueValidState) {
          _compoundNameErrorMessage = null;
          _unitNoErrorMessage = null;
          if (_documents.isEmpty) {
            _onSaveDocuments();
          } else {
            _bloc.add(OnTapStepEvent(id: state.nextPageId));
          }
        } else if (state is OnTapStepState) {
          _currentIndex = state.id;
          print(_currentIndex);
          _pageController.jumpToPage(_currentIndex - 1);
        } else if (state is DocumentsNotValidState) {
          _documents = state.documents;
          for (var element in _documents) {
            if (element.errorMessage.isNotEmpty) {
              _scrollToElementKey(element.key!);
              break;
            }
          }
          _isImagesRequired = true;
        } else if (state is RegisterErrorState) {
          showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.error,
              buttonText: S.of(context).ok,
              onTap: () {
                Navigator.pop(context);
              });
        } else if (state is AddUnitSuccessState) {
          _bloc.add(CheckNewUnitEvent(
            userUnit: state.userUnit,
            message: state.message,
          ));
        } else if (state is NewUnitIsActiveState) {
          showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.success,
              buttonText: S.of(context).ok,
              onTap: () async {
                (await SharedPreferences.getInstance())
                    .setBool(SharedPreferenceKeys.isRestart, true);
                RestartWidget.restartApp(context);
              });
        } else if (state is NavigateToLoginState) {
          showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.success,
              buttonText: S.of(context).ok,
              onTap: () async {
                Navigator.pop(context);
                Navigator.pop(context, true);
              });
        } else if (state is NewUnitNotActiveState) {
          showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.info,
              buttonText: S.of(context).ok,
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              HeaderWidget(
                title: S.of(context).addUnit,
                hasBackButton: true,
                backButtonAction: () {
                  Navigator.pop(context);
                },
              ),
              StepsWidget(
                steps: [
                  Steps(id: 1, name: S.of(context).compound),
                  if (_documents.isNotEmpty)
                    Steps(id: 2, name: S.of(context).documents),
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
                  if (_documents.isNotEmpty)
                    DocumentsWidget(
                      documents: _documents,
                      isImagesRequired: _isImagesRequired,
                      onTapImage: (PageField document) {
                        _bloc.add(OnTapDocumentImageEvent(document: document));
                      },
                      onTapFile: (PageField document) {
                        _bloc.add(OnTapDocumentFileEvent(document: document));
                      },
                      deleteFileAction: (PageField document) {
                        _dialogMessage(
                            icon: ImagePaths.warning,
                            message:
                                S.of(context).areYouSureYouWantToDeleteThisFile,
                            primaryAction: () {
                              _bloc.add(DeleteFileEvent(document: document));
                            });
                      },
                      deleteImageAction: (PageField document) {
                        _dialogMessage(
                            icon: ImagePaths.warning,
                            message: S
                                .of(context)
                                .areYouSureYouWantToDeleteThisImage,
                            primaryAction: () {
                              _bloc.add(DeleteImageEvent(document: document));
                            });
                      },
                      onAddMultipleImageTap: (document, min, max) {
                        _maxMultipleImages = max;
                        _minMultipleImages = min;
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
                      maxMultipleImages: _maxMultipleImages,
                      minMultipleImages: _minMultipleImages,
                      scrollController: scrollController,
                    )
                ],
                onTapStep: (int currentIndex) {
                  _onTapStep(currentIndex);
                },
                currentIndex: _currentIndex,
                pageController: _pageController,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButtonWidget(
                      onTap: () {
                        if (_currentIndex == 1) {
                          _bloc.add(CompoundSaveAndContinueEvent(
                            compoundName: _compoundNameController.text,
                            unitNumber: _unitNumberController.text,
                            nextPageId: _currentIndex + 1,
                          ));
                        } else {
                          _onSaveDocuments();
                        }
                      },
                      text: S.of(context).saveContinue,
                      width: double.infinity,
                      backgroundColor: F.isNiceTouch
                          ? ColorSchemes.ghadeerDarkBlue
                          : ColorSchemes.primary,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Container(
                      height: 1,
                      color: ColorSchemes.lightGray,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: Text(
                      S.of(context).addTheUnitsYouOwnOrRentToThisAccount,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorSchemes.black,
                            letterSpacing: -0.13,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSaveDocuments() {
    RegisterRequest request = RegisterRequest(
      unitId: _unitNumber.id.toString(),
      userTypeId: _userTypeId.toString(),
      name: "",
      email: "",
      mobileNumber: "",
      password: "",
      files: _documents.mapToDomain(),
    );

    _bloc.add(DocumentsSaveAndContinueEvent(
      documents: _documents,
      request: request,
      userId: widget.userId,
    ));
  }

  void _navigateBack() {
    Navigator.pop(context);
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
              if (await PermissionServiceHandler().handleServicePermission(
                  setting: isCamera
                      ? PermissionServiceHandler.getCameraPermission()
                      : PermissionServiceHandler
                          .getSingleImageGalleryPermission())) {}
            });
          });
    }
  }

  void _imagePiker({
    required ImageSource source,
    required PageField document,
  }) async {
    await _picker.pickImage(source: source).then((value) async {
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

  void _navigateToCompoundScreenState() {
    Navigator.pushNamed(
      context,
      Routes.compound,
      arguments: _compound,
    ).then((value) {
      Compound compound = const Compound();
      compound = _compound;
      _compound = value as Compound;
      if (compound.id != _compound.id) {
        _unitNumberController.text = '';
        _compoundNameController.text = _compound.name;
        _bloc.add(ValidateCompoundNameEvent(
          compoundName: _compound.name,
        ));
        _bloc.add(GetDocumentsPageEvent(
            pageFieldsRequest: PageFieldsRequest(
          compoundId: _compound.id,
          userTypeId: _userTypeId,
          generalExtrafield: [
            const PageCodeRequest(pageCode: PageKeys.userFile),
          ],
        )));
      }
    });
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

  Future<void> _pickPDFFile({
    required PageField document,
  }) async {
    if (await PermissionServiceHandler()
        .handleServicePermission(setting: Permission.storage)) {
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
              if (await PermissionServiceHandler()
                  .handleServicePermission(setting: Permission.storage)) {}
            });
          });
    }
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
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler.getCameraPermission())) {}
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
          setting: PermissionServiceHandler.getSingleImageGalleryPermission(),
        )) {
          _getImage(document, ImageSource.gallery, true);
        } else {
          _showActionDialog(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _navigateBack();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                  setting: PermissionServiceHandler
                      .getSingleImageGalleryPermission(),
                )) {}
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
    );
  }

  Future<void> _getImage(
    PageField document,
    ImageSource img, [
    bool isMultiple = false,
  ]) async {
    final ImagePicker picker = ImagePicker();
    if (isMultiple) {
      List<AssetEntity>? images = await AssetPicker.pickAssets(
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
      } else {
        return;
      }

      await convertAssetEntitiesToFiles(imagesAssets).then((value) {
        _bloc.add(SelectMultipleImageEvent(
            document: document, images: value + cameraImages));
      });
    } else {
      final pickedFile = await picker.pickImage(
        source: img,
      );
      if (pickedFile != null) {
        XFile? imageFile = await compressFile(File(pickedFile.path));
        cameraImages.add(File(imageFile!.path));
        selectedMultiImagesCount++;
        _bloc.add(AddMultipleImageEvent(document: document, image: imageFile!));
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
        userId: widget.userId,
        selectedUnit: _selectedUnit,
      ),
      titleLabel: S.of(context).selectUnit,
    ).then((value) {
      if (value != null) {
        _selectedUnit = value['selectedUnit'];
        _unitNumber = value['selectedUnit'];
        _unitNumberController.text = value['unitName'];
        _bloc.add(ValidateUnitNumberEvent(
          unitNumber: value['unitName'],
        ));
      }
    });
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
    }
  }

  Future<void> _scrollToElementKey(GlobalKey<State<StatefulWidget>> key) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Scrollable.ensureVisible(key.currentContext ?? context);
  }
}
