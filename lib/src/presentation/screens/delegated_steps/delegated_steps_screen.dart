import 'dart:io';
import 'dart:typed_data';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/android_date_picker.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/convert_timestamp_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/ios_date_picker.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_searchable_bottom_sheet.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/submit_delegated_request.dart';
import 'package:city_eye/src/di/data_layer_injector.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/domain/entities/steps/steps.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:city_eye/src/presentation/blocs/delegated/delegated_bloc.dart';
import 'package:city_eye/src/presentation/blocs/delegated_steps/delegated_steps_bloc.dart';
import 'package:city_eye/src/presentation/screens/delegated_steps/skeleton/delegated_steps_skeleton.dart';
import 'package:city_eye/src/presentation/screens/delegated_steps/widgets/authorized_widget.dart';
import 'package:city_eye/src/presentation/screens/delegated_steps/widgets/preview_widget.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/signature_widget.dart';
import 'package:city_eye/src/presentation/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widgets/owner_widget.dart';

// ignore: must_be_immutable
class DelegatedStepsScreen extends BaseStatefulWidget {
  DelegatedStepsScreen(
      {required this.isEdit, required this.delegatedData, super.key});

  bool isEdit = false;
  Delegated delegatedData;

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _DelegatedStepsScreenState();
}

int _currentIndex = 1;
late PageController _pageController;

class _DelegatedStepsScreenState extends BaseState<DelegatedStepsScreen> {
  DelegatedStepsBloc get _bloc => BlocProvider.of<DelegatedStepsBloc>(context);

  // ************  Owner Screen *****************
  final ScrollController scrollController = ScrollController();
  final _messageController = TextEditingController();
  final _nameController = TextEditingController();
  final _unitNoController = TextEditingController();
  final _idController = TextEditingController();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  String? _selectedImage;
  String _selectedImageNetwork = "";
  Uint8List? _signatureImage;
  String _signatureImageNetwork = "";
  DateTime? _dateFrom;
  DateTime? _dateTo;
  bool _isCaptureSignature = false;

  String? _messageErrorMessage;
  String? _idErrorMessage;
  String? _dateFromErrorMessage;
  String? _dateToErrorMessage;
  String? _selectImageErrorMessage;
  String? _signatureErrorMessage;

  var messageKey = GlobalKey();
  var idKey = GlobalKey();
  var imageKey = GlobalKey();
  var captureSignatureKey = GlobalKey();
  var dateKey = GlobalKey();

  // ************  Authorized Screen *****************
  final _authNameController = TextEditingController();
  final _authIdController = TextEditingController();
  final _authMobileNumberController = TextEditingController();

  bool _authIsCaptureSignature = false;

  String? _authSelectedImage;
  String _authSelectedImageNetwork = "";
  Uint8List? _authSignatureImage;
  String _authSignatureImageNetwork = "";

  String? _authNameErrorMessage;
  String? _authIdErrorMessage;
  String? _authMobileNumberErrorMessage;
  String? _authSelectImageErrorMessage;
  String? _authSignatureErrorMessage;

  String _authCountryCode = "EG";

  var authNameKey = GlobalKey();
  var authIdKey = GlobalKey();
  var authMobileKey = GlobalKey();
  var authImageKey = GlobalKey();
  var authCaptureSignatureKey = GlobalKey();

  // ************  Steps Screen *****************
  int nextIndex = 0;
  String pdfUri = "";
  bool isUnsavedChangedDate = false;
  bool shouldPop = true;

  BuildContext? scrollKey;
  BuildContext? authScrollKey;

  List<PageField> _ownerQuestions = [];
  List<PageField> _authQuestions = [];

  @override
  void initState() {
    if (widget.isEdit) {
      _authCountryCode = widget.delegatedData.authCountryCode;
    } else {
      _authCountryCode = GetCurrentCountryCodeUseCase(injector())();
    }
    _pageController = PageController(initialPage: _currentIndex - 1);
    _bloc.add(OwnerGetUserInformationEvent());
    super.initState();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<DelegatedStepsBloc, DelegatedStepsState>(
      listener: (context, state) {
        /*********************  Owner States **********************/
        if (state is ShowStepsLoadingState) {
          showLoading();
        } else if (state is HideStepsLoadingState) {
          hideLoading();
        } else if (state is GetQuestionsSuccessState) {
          _ownerQuestions = state.ownerQuestions;
          _authQuestions = state.authQuestions;
          if (!widget.isEdit) {
            _bloc.add(AuthMapQuestionToWidgetEvent());
          }
        } else if (state is GetQuestionsErrorState) {
          _showMassageDialogWidget(
            state.errorMessage,
            ImagePaths.error,
          );
        } else if (state is OwnerGetUserInformationState) {
          _nameController.text = state.userInfo.userInformation.name;
          _unitNoController.text = state.unitNumber;

          if (widget.isEdit) {
            _bloc.add(SetEditDateEvent());
          } else {
            _bloc.add(GetQuestionsEvent());
            // if (_currentIndex == 1) {
            // _bloc.add(MapQuestionToWidgetEvent());
            // } else {
            // }
          }
          _currentIndex = 1;
          _pageController.jumpToPage(_currentIndex - 1);
        } else if (state is SetEditDateState) {
          _dateFrom = DateTime.parse(widget.delegatedData.fromDate);
          _dateTo = DateTime.parse(widget.delegatedData.toDate);
          _dateFromController.text = widget.delegatedData.fromDate;
          _dateToController.text = widget.delegatedData.toDate;
          _dateFromController.text = englishNumbers(
              convertTimestampToDateIntoFormatDelegation(
                  widget.delegatedData.fromDate.toString()));
          _dateToController.text = englishNumbers(
              convertTimestampToDateIntoFormatDelegation(
                  widget.delegatedData.toDate.toString()));
          _idController.text = widget.delegatedData.personalID;
          _messageController.text = widget.delegatedData.notes;
          _authIdController.text = widget.delegatedData.authPersonalID;
          _authNameController.text = widget.delegatedData.authName;
          _authMobileNumberController.text = widget.delegatedData.authMobile;
          _selectedImageNetwork = widget.delegatedData.ownerIDAttachment;
          _authSelectedImageNetwork = widget.delegatedData.authIDAttachment;
          _signatureImageNetwork =
              widget.delegatedData.ownerSignatureAttachment;
          _authSignatureImageNetwork =
              widget.delegatedData.authSignatureAttachment;
          _authCountryCode = widget.delegatedData.authCountryCode;
          _ownerQuestions = widget.delegatedData.ownerExtraField;
          _bloc.ownerQuestions = widget.delegatedData.ownerExtraField;
          _authQuestions = widget.delegatedData.authExtraField;
          _bloc.authQuestions = widget.delegatedData.authExtraField;
          for (int i = 0; i < _ownerQuestions.length; i++) {
            if (_ownerQuestions[i].code == QuestionsCode.image) {
              _ownerQuestions[i] = _ownerQuestions[i].copyWith(
                isFromServer: true,
              );
            }
          }
          for (int i = 0; i < _authQuestions.length; i++) {
            if (_authQuestions[i].code == QuestionsCode.image) {
              _authQuestions[i] = _authQuestions[i].copyWith(
                isFromServer: true,
              );
            }
          }
          _bloc.add(MapQuestionToWidgetEvent());
          _bloc.add(AuthMapQuestionToWidgetEvent());
        } else if (state is DelegatedPickImageState) {
          if (_currentIndex == 1) {
            _selectedImage = state.imageFile.path;
            _selectImageErrorMessage = null;
            _selectedImageNetwork = "";
          } else {
            _authSelectedImage = state.imageFile.path;
            _authSelectImageErrorMessage = null;
            _authSelectedImageNetwork = "";
          }
          isUnsavedChangedDate = true;
        } else if (state is DelegatedImagePermissionDeniedState) {
          _showActionDialogWidget(
            icon: ImagePaths.warning,
            text: S.of(context).youShouldHaveCameraPermission,
            primaryText: S.of(context).settings,
            secondaryText: S.of(context).canceled,
            onPrimaryAction: () async {
              Navigator.pop(context);
              openAppSettings();
            },
            onSecondaryAction: () => _popBack(),
          );
        } else if (state is DelegatedShowMassageDialogState) {
          _showMassageDialogWidget(
            state.message,
            state.icon,
          );
        } else if (state is DelegatedDeleteImageState) {
          if (_currentIndex == 1) {
            _selectedImage = null;
            _selectedImageNetwork = "";
            _selectImageErrorMessage = S.of(context).thisFieldIsRequired;
          } else {
            _authSelectedImage = null;
            _authSelectedImageNetwork = "";
            _authSelectImageErrorMessage = S.of(context).thisFieldIsRequired;
          }
          isUnsavedChangedDate = true;
        } else if (state is DelegatedCaptureSignatureState) {
        } else if (state is DelegatedSelectedDateState) {
          if (state.isFrom) {
            _dateFromController.text = englishNumbers(
                convertTimestampToDateIntoFormatDelegation(state.date));
          } else {
            _dateToController.text = englishNumbers(
                convertTimestampToDateIntoFormatDelegation(state.date));
          }
          isUnsavedChangedDate = true;
        } else if (state is OnOwnerSaveState) {
          _currentIndex = nextIndex == 0 ? 2 : nextIndex;
          _pageController.jumpToPage(_currentIndex - 1);
          isUnsavedChangedDate = false;
          nextIndex = 0;
          _bloc.add(MapQuestionToWidgetEvent());
        } else if (state is OnTapStepState) {
          if (_currentIndex == 1) {
            _bloc.add(AuthMapQuestionToWidgetEvent());
          }
          if ((_currentIndex == 1 && state.id != 3) || _currentIndex == 2) {
            _currentIndex = state.id;
            _pageController.jumpToPage(_currentIndex - 1);
          }
          nextIndex = 0;
          isUnsavedChangedDate = false;
        } else if (state is ValidateMessageValidFormatState) {
          _messageErrorMessage = null;
        } else if (state is ValidateMessageEmptyFormatState) {
          _messageErrorMessage = S.of(context).thisFieldIsRequired;
          _scrollTo();
        } else if (state is ValidateIdValidFormatState) {
          if (_currentIndex == 1) {
            _idErrorMessage = null;
          } else {
            _authIdErrorMessage = null;
          }
        } else if (state is ValidateIdEmptyFormatState) {
          if (_currentIndex == 1) {
            _idErrorMessage = S.of(context).thisFieldIsRequired;
            _scrollTo();
          } else {
            _authIdErrorMessage = S.of(context).thisFieldIsRequired;
            _authScrollTo();
          }
        } else if (state is ValidateDateFromValidFormatState) {
          _dateFromErrorMessage = null;
          isUnsavedChangedDate = true;
        } else if (state is ValidateDateFromEmptyFormatState) {
          _dateFromErrorMessage = S.of(context).thisFieldIsRequired;
          _scrollTo();
        } else if (state is ValidateDateToValidFormatState) {
          _dateToErrorMessage = null;
          isUnsavedChangedDate = true;
        } else if (state is ValidateDateToEmptyFormatState) {
          _dateToErrorMessage = S.of(context).thisFieldIsRequired;
          _scrollTo();
        } else if (state is ValidateSelectImageValidState) {
          if (_currentIndex == 1) {
            _selectImageErrorMessage = null;
          } else {
            _authSelectImageErrorMessage = null;
          }
          isUnsavedChangedDate = true;
        } else if (state is ValidateSelectImageEmptyState) {
          if (_currentIndex == 1) {
            _selectImageErrorMessage = _selectedImageNetwork == ""
                ? state.imageValidatorMessage
                : null;
            _scrollTo();
          } else {
            _authSelectImageErrorMessage = _authSelectedImageNetwork == ""
                ? state.imageValidatorMessage
                : null;
            _authScrollTo();
          }
        } else if (state is ValidateSignatureValidState) {
          if (state.bytes != null) {
            _signatureErrorMessage = null;
            _isCaptureSignature = true;
            _signatureImage = state.bytes;
            isUnsavedChangedDate = true;
            _signatureImageNetwork = "";
          }
        } else if (state is ValidateSignatureEmptyState) {
          if (_currentIndex == 1) {
            _signatureErrorMessage = state.signatureErrorMessage;
            _scrollTo();
          }
          // isUnsavedChangedDate = true;
        } else if (state is ClearSignatureState) {
          if (_currentIndex == 1) {
            _isCaptureSignature = false;
            if (_signatureImage != null) isUnsavedChangedDate = true;
            _signatureImage = null;
            _signatureErrorMessage = S.of(context).signatureRequired;
            _signatureImageNetwork = "";
          } else {
            _authIsCaptureSignature = false;
            if (_authSignatureImage != null) isUnsavedChangedDate = true;
            _authSignatureImage = null;
            _authSignatureImageNetwork = '';
          }
        }
        /*********************  Authorized States **********************/
        else if (state is AuthIsValidateState) {
          _submitDelegation();
        } else if (state is OnAuthorizedSaveSuccessState) {
          pdfUri = state.submitDelegation.link;
          _currentIndex = nextIndex == 0 ? 3 : nextIndex;
          _pageController.jumpToPage(_currentIndex - 1);
          isUnsavedChangedDate = false;
          nextIndex = 0;
        } else if (state is OnAuthorizedSaveErrorState) {
          showMassageDialogWidget(
            context: context,
            text: state.errorMessage,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () => {
              _popBack(),
            },
          );
        } else if (state is ValidateAuthNameEmptyFormatState) {
          _authNameErrorMessage = state.nameValidatorMessage;
          _authScrollTo();
        } else if (state is ValidateAuthNameValidFormatState) {
          _authNameErrorMessage = null;
          // isUnsavedChangedDate = true;
        } else if (state is ValidateAuthMobileNumberEmptyFormatState) {
          _authMobileNumberErrorMessage = state.mobileValidatorMessage;
          _authScrollTo();
        } else if (state is ValidateAuthMobileNumberValidFormatState) {
          _authMobileNumberErrorMessage = null;
          isUnsavedChangedDate = true;
        } else if (state is AuthSaveSignatureState) {
          if (state.bytes != null) {
            _authIsCaptureSignature = true;
            _authSignatureImage = state.bytes!;
            isUnsavedChangedDate = true;
            _authSignatureImageNetwork = '';
          }
        }
        /****************** Preview States *****************/
        else if (state is PreviewOnTapDoneState) {
          _currentIndex = 1;
          _pageController.jumpToPage(_currentIndex - 1);
          BlocProvider.of<DelegatedBloc>(context).isReloadList = true;
          Navigator.pop(context, Routes.delegated);
        }
        /******************* Dynamic Widgets States ****************************/
        else if (state is MapQuestionToWidgetState) {
          _ownerQuestions = state.questions;
          nextIndex = 0;
        } else if (state is AuthMapQuestionToWidgetState) {
          _authQuestions = state.questions;
        } else if (state is UpdateMapQuestionToWidgetState) {
          _ownerQuestions = state.questions;
          isUnsavedChangedDate = true;
        } else if (state is UpdateAuthMapQuestionToWidgetState) {
          _authQuestions = state.questions;
          isUnsavedChangedDate = true;
        } else if (state is ShowMediaBottomSheetState) {
          showMediaBottomSheet(question: state.question);
        } else if (state is ShowDialogToDeleteQuestionAnswerState) {
          _showActionDialogWidget(
              icon: ImagePaths.warning,
              text: S.of(context).areYouSureYouWantToDeleteThisImage,
              onPrimaryAction: () {
                if (_currentIndex == 1) {
                  _bloc
                      .add(DeleteQuestionAnswerEvent(question: state.question));
                } else {
                  _bloc.add(
                      AuthDeleteQuestionAnswerEvent(question: state.question));
                }
                Navigator.of(context).pop();
              },
              onSecondaryAction: () {
                Navigator.of(context).pop();
              },
              primaryText: S.of(context).yes,
              secondaryText: S.of(context).no);
        } else if (state is ScrollToUnAnsweredMandatoryQuestionState) {
          if (_currentIndex == 1) {
            scrollKey = state.key.currentContext;
            _scrollTo();
          } else {
            authScrollKey = state.key.currentContext;
            _authScrollTo();
          }
          // isUnsavedChangedDate = true;
        } else if (state is ShowQrSearchableBottomSheetState) {
          _openSearchableBottomSheet(state.question, state.isMultiChoice);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBarWidget(context,
              title: S.of(context).delegated,
              isHaveBackButton: true, onBackButtonPressed: () {
            screenPopBack();
            if (shouldPop) {
              _popBack();
            }
          }),
          body: WillPopScope(
            onWillPop: () async {
              screenPopBack();
              return shouldPop;
            },
            child: state is ShowStepsSkeletonState ||
                    state is OwnerGetUserInformationState
                ? const DelegatedStepsSkeleton()
                : Column(
                    children: [
                      StepsWidget(
                        steps: [
                          Steps(id: 1, name: S.of(context).owner),
                          Steps(id: 2, name: S.of(context).authorized),
                          Steps(id: 3, name: S.of(context).preview),
                        ],
                        pages: [
                          OwnerWidget(
                            question: _ownerQuestions,
                            messageKey: messageKey,
                            idKey: idKey,
                            imageKey: imageKey,
                            captureSignatureKey: captureSignatureKey,
                            dateKey: dateKey,
                            onTapSingleSelection: (element, answerId) {
                              _bloc.add(SelectSingleSelectionAnswerEvent(
                                  question: element, answerId: answerId));
                            },
                            onTapMultiSelection: (element, answerId) {
                              _bloc.add(SelectMultiSelectionAnswerEvent(
                                  answerId: answerId, question: element));
                            },
                            onTapPickDateAnswer: (element, answer) {
                              _bloc.add(AddAnswerToQuestionEvent(
                                  answer: answer, question: element));
                            },
                            onTapDateDeleteAnswer: (element) {
                              _bloc.add(
                                  DeleteQuestionAnswerEvent(question: element));
                            },
                            onTapTextAnswerQuestion: (element, answer) {
                              _bloc.add(AddAnswerToQuestionEvent(
                                  question: element, answer: answer));
                            },
                            onTapNumericAnswerQuestion: (element, answer) {
                              _bloc.add(AddAnswerToQuestionEvent(
                                  question: element, answer: answer));
                            },
                            onShowUploadImageBottomSheet: (element) {
                              _bloc.add(
                                  ShowMediaBottomSheetEvent(question: element));
                            },
                            onShowDialogToDeleteImage: (element) {
                              _bloc.add(ShowDialogToDeleteQuestionAnswerEvent(
                                  question: element));
                            },
                            onOpenSearchableBottomSheet:
                                (element, isMultiChoice) {
                              _bloc.add(ShowQrSearchableBottomSheetEvent(
                                  question: element,
                                  isMultiChoice: isMultiChoice));
                            },
                            onTapImagePreview: (image) {
                              _onTapImagePreview(image);
                            },
                            messageController: _messageController,
                            messageErrorMessage: _messageErrorMessage,
                            nameController: _nameController,
                            unitNoController: _unitNoController,
                            idController: _idController,
                            idErrorMessage: _idErrorMessage,
                            dateFromController: _dateFromController,
                            dateFromErrorMessage: _dateFromErrorMessage,
                            dateToController: _dateToController,
                            dateToErrorMessage: _dateToErrorMessage,
                            selectImageErrorMessage: _selectImageErrorMessage,
                            captureSignatureErrorMessage:
                                _signatureErrorMessage,
                            selectedImage: _selectedImage != null
                                ? File(_selectedImage!)
                                : null,
                            selectedImageNetwork: _selectedImageNetwork,
                            isNetwork: _selectedImageNetwork != "",
                            isCaptureSignature: _isCaptureSignature,
                            onTapUploadImage: () {
                              _uploadMediaBottomSheet();
                            },
                            onTapDeleteImage: () {
                              _showActionDialogWidget(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantDeleteThisImage,
                                primaryText: S.of(context).cancel,
                                secondaryText: S.of(context).delete,
                                onPrimaryAction: () => _popBack(),
                                onSecondaryAction: () {
                                  _popBack();
                                  _bloc.add(DelegatedDeleteImageEvent());
                                },
                              );
                            },
                            onTapCaptureSignature: () {
                              _showSignatureBottomSheetWidget();
                            },
                            onTapSelectedDate: (isDateFrom) {
                              if (isDateFrom) {
                                _selectDate(context, isDateFrom);
                              } else {
                                if (_dateFrom == null &&
                                    _dateFromController.text.isEmpty) {
                                  _showMassageDialogWidget(
                                    S.of(context).youShouldSelectFromDateFirst,
                                    ImagePaths.error,
                                  );
                                } else {
                                  _selectDate(context, isDateFrom);
                                }
                              }
                            },
                            onSaveOwnerData: () {
                              _onSaveOwnerData();
                            },
                            onMessageChanged: (string) {
                              isUnsavedChangedDate = true;
                              _bloc.add(DelegatedValidateMessageEvent(string));
                            },
                            onIdChanged: (string) {
                              isUnsavedChangedDate = true;
                              _bloc.add(DelegatedValidateIdEvent(string));
                            },
                            onClearSignature: () {
                              _showActionDialogWidget(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantToClearSignature,
                                primaryText: S.of(context).no,
                                secondaryText: S.of(context).yes,
                                onPrimaryAction: () {
                                  _popBack();
                                },
                                onSecondaryAction: () {
                                  _popBack();
                                  _bloc.add(ClearSignatureEvent());
                                },
                              );
                            },
                            signatureImage:
                                _signatureImage ?? Uint8List.fromList([]),
                            signatureImageNetwork: _signatureImageNetwork,
                          ),
                          AuthorizedWidget(
                            question: _authQuestions,
                            nameKey: authNameKey,
                            idKey: authIdKey,
                            mobileKey: authMobileKey,
                            imageKey: authImageKey,
                            mobileInitialValue: widget.delegatedData.authMobile,
                            countryCode: _authCountryCode,
                            captureSignatureKey: authCaptureSignatureKey,
                            onTapSingleSelection: (element, answerId) {
                              _bloc.add(AuthSelectSingleSelectionAnswerEvent(
                                  question: element, answerId: answerId));
                            },
                            onTapMultiSelection: (element, answerId) {
                              _bloc.add(AuthSelectMultiSelectionAnswerEvent(
                                  answerId: answerId, question: element));
                            },
                            onTapPickDateAnswer: (element, answer) {
                              _bloc.add(AuthAddAnswerToQuestionEvent(
                                  answer: answer, question: element));
                            },
                            onTapDateDeleteAnswer: (element) {
                              _bloc.add(AuthDeleteQuestionAnswerEvent(
                                  question: element));
                            },
                            onTapTextAnswerQuestion: (element, answer) {
                              _bloc.add(AuthAddAnswerToQuestionEvent(
                                  question: element, answer: answer));
                            },
                            onTapNumericAnswerQuestion: (element, answer) {
                              _bloc.add(AuthAddAnswerToQuestionEvent(
                                  question: element, answer: answer));
                            },
                            onShowUploadImageBottomSheet: (element) {
                              _bloc.add(AuthShowMediaBottomSheetEvent(
                                  question: element));
                            },
                            onShowDialogToDeleteImage: (element) {
                              _bloc.add(
                                  AuthShowDialogToDeleteQuestionAnswerEvent(
                                      question: element));
                            },
                            onOpenSearchableBottomSheet:
                                (element, isMultiChoice) {
                              _bloc.add(ShowQrSearchableBottomSheetEvent(
                                  question: element,
                                  isMultiChoice: isMultiChoice));
                            },
                            onTapImagePreview: (image) {
                              _onTapImagePreview(image);
                            },
                            nameController: _authNameController,
                            idController: _authIdController,
                            mobileNoController: _authMobileNumberController,
                            selectedImage: _authSelectedImage != null
                                ? File(_authSelectedImage!)
                                : null,
                            selectedImageNetwork: _authSelectedImageNetwork,
                            isNetwork: _authSelectedImageNetwork != "",
                            nameErrorMessage: _authNameErrorMessage,
                            idErrorMessage: _authIdErrorMessage,
                            mobileNumberErrorMessage:
                                _authMobileNumberErrorMessage,
                            selectImageErrorMessage:
                                _authSelectImageErrorMessage,
                            signatureErrorMessage: _authSignatureErrorMessage,
                            isCaptureSignature: _authIsCaptureSignature,
                            onNameChanged: (value) {
                              isUnsavedChangedDate = true;
                              _bloc.add(ValidateAuthNameFormatEvent(value));
                            },
                            onIdChanged: (value) {
                              isUnsavedChangedDate = true;
                              _bloc.add(DelegatedValidateIdEvent(value));
                            },
                            onMobileNumberChanged: (phoneNumber, countryCode) {
                              isUnsavedChangedDate = true;
                              _authMobileNumberController.text =
                                  englishNumbers(phoneNumber);
                              _authCountryCode = countryCode;
                              _bloc.add(ValidateAuthMobileNumberFormatEvent(
                                  phoneNumber, countryCode));
                            },
                            onTapUploadImage: () {
                              _uploadMediaBottomSheet();
                            },
                            onTapDeleteImage: () {
                              _showActionDialogWidget(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantDeleteThisImage,
                                primaryText: S.of(context).cancel,
                                secondaryText: S.of(context).delete,
                                onPrimaryAction: () => _popBack(),
                                onSecondaryAction: () {
                                  _popBack();
                                  _bloc.add(DelegatedDeleteImageEvent());
                                },
                              );
                            },
                            onTapCaptureSignature: () {
                              _showSignatureBottomSheetWidget();
                            },
                            onSaveAuthData: () {
                              _onSaveAuthData();
                            },
                            onClearSignature: () {
                              _showActionDialogWidget(
                                icon: ImagePaths.warning,
                                text: S
                                    .of(context)
                                    .areYouSureYouWantToClearSignature,
                                primaryText: S.of(context).no,
                                secondaryText: S.of(context).yes,
                                onPrimaryAction: () {
                                  _popBack();
                                },
                                onSecondaryAction: () {
                                  _popBack();
                                  _bloc.add(ClearSignatureEvent());
                                },
                              );
                            },
                            signatureImage:
                                _authSignatureImage ?? Uint8List.fromList([]),
                            signatureImageNetwork: _authSignatureImageNetwork,
                          ),
                          PreviewWidget(
                              pdfUrl: pdfUri,
                              onTapPreviewDone: () {
                                _bloc.add(PreviewOnTapDoneEvent());
                              }),
                        ],
                        onTapStep: (int currentIndex) {
                          _onTapStep(currentIndex);
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

  void _selectDate(BuildContext context, bool isDateFrom) {
    if (Platform.isAndroid) {
      androidDatePicker(
        context: context,
        firstDate: isDateFrom
            ? DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            : _dateFrom!.add(const Duration(days: 1)),
        onSelectDate: (date) {
          if (date == null) return;
          if (isDateFrom) {
            _dateFrom = date;
            _dateTo = null;
            _dateToController.text = "";
            _bloc.add(
                DelegatedSelectedDateEvent(_dateFrom.toString(), isDateFrom));
          } else {
            Duration difference = date.difference(_dateFrom!);
            if (difference.inDays > 0) {
              _dateTo = date;
              _bloc.add(
                  DelegatedSelectedDateEvent(_dateTo.toString(), isDateFrom));
            } else {
              _bloc.add(DelegatedShowMassageDialogEvent(
                  "${S.current.thisDateShouldBeGreaterThan} ${englishNumbers(_dateFromController.text)}",
                  ImagePaths.error));
            }
          }

          if (isDateFrom) {
            _bloc.add(DelegatedValidateDateFromEvent(_dateFrom.toString()));
          }
          if (!isDateFrom && _dateTo != null) {
            _bloc.add(DelegatedValidateDateToEvent(_dateTo.toString()));
          }
        },
        selectedDate: isDateFrom
            ? _dateFrom ?? DateTime.now()
            : _dateTo ?? _dateFrom!.add(const Duration(days: 1)),
        helpText: _dateFrom == null
            ? S.of(context).selectFromDate
            : S.of(context).selectToDate,
      );
    } else {
      DateTime tempDate = isDateFrom
          ? _dateFrom ?? DateTime.now()
          : _dateTo ?? _dateFrom!.add(const Duration(days: 1));
      iosDatePicker(
        context: context,
        selectedDate: isDateFrom
            ? _dateFrom ?? DateTime.now()
            : _dateTo ?? _dateFrom!.add(const Duration(days: 1)),
        minimumDate: isDateFrom
            ? DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            : _dateFrom!.add(const Duration(days: 1)),
        onChange: (date) {
          tempDate = date;
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
        onDone: () {
          if (isDateFrom) {
            _dateFrom = tempDate;
            _dateTo = null;
            _dateToController.text = "";
            _bloc.add(
                DelegatedSelectedDateEvent(_dateFrom.toString(), isDateFrom));
          } else {
            Duration difference = tempDate.difference(_dateFrom!);
            if (difference.inDays > 0) {
              _dateTo = tempDate;
              _bloc.add(
                  DelegatedSelectedDateEvent(_dateTo.toString(), isDateFrom));
            } else {
              _bloc.add(DelegatedShowMassageDialogEvent(
                  "${S.current.thisDateShouldBeGreaterThan} ${englishNumbers(_dateFromController.text)}",
                  ImagePaths.error));
            }
          }

          if (isDateFrom) {
            _bloc.add(DelegatedValidateDateFromEvent(_dateFrom.toString()));
          }
          if (!isDateFrom && _dateTo != null) {
            _bloc.add(DelegatedValidateDateToEvent(_dateTo.toString()));
          }
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<void> _selectImage(bool isCamera) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      XFile? file = await compressFile(File(pickedFile.path));
      if (file != null) {
        _bloc.add(DelegatedPickImageEvent(File(file.path)));
      }
    } else {
      if ((_selectedImage == null && _currentIndex == 1) ||
          (_authSelectedImage == null && _currentIndex == 2)) {
        _bloc.add(DelegatedValidateSelectImageEvent(""));
      }
    }
  }

  void _showMassageDialogWidget(
    String text,
    String icon,
  ) {
    showMassageDialogWidget(
      context: context,
      text: text,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  void _showActionDialogWidget({
    required String text,
    required String icon,
    required String primaryText,
    required String secondaryText,
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
  }) {
    showActionDialogWidget(
      context: context,
      icon: icon,
      text: text,
      primaryText: primaryText,
      secondaryText: secondaryText,
      primaryAction: () {
        onPrimaryAction();
      },
      secondaryAction: () {
        onSecondaryAction();
      },
    );
  }

  void _popBack() {
    Navigator.pop(context);
  }

  void _uploadMediaBottomSheet() {
    FocusScope.of(context).unfocus();
    showBottomSheetUploadMedia(
        context: context,
        onTapCamera: () async {
          _popBack();
          if (await PermissionServiceHandler().handleServicePermission(
              setting: PermissionServiceHandler.getCameraPermission())) {
            _selectImage(true);
          } else {
            _showActionDialogWidget(
              icon: ImagePaths.warning,
              onPrimaryAction: () {
                _popBack();
                openAppSettings();
              },
              onSecondaryAction: () {
                _popBack();
              },
              primaryText: S.current.ok,
              secondaryText: S.current.cancel,
              text: S.current.youShouldHaveCameraPermission,
            );
          }
        },
        onTapGallery: () async {
          _popBack();
          if (await PermissionServiceHandler().handleServicePermission(
              setting:
                  PermissionServiceHandler.getSingleImageGalleryPermission())) {
            _selectImage(false);
          } else {
            _showActionDialogWidget(
              icon: ImagePaths.warning,
              onPrimaryAction: () {
                _popBack();
                openAppSettings().then((value) async {
                  if (await PermissionServiceHandler().handleServicePermission(
                      setting: PermissionServiceHandler
                          .getSingleImageGalleryPermission())) {}
                });
              },
              onSecondaryAction: () {
                _popBack();
              },
              primaryText: S.current.ok,
              secondaryText: S.current.cancel,
              text: Platform.isIOS
                  ? S.current.youShouldHaveStoragePermission
                  : S.current.youShouldHaveCameraPermission,
            );
          }
        });
  }

  void _onTapStep(int newIndex) {
    if (newIndex != 3) {
      _ownerQuestions = _bloc.ownerQuestions;
      _authQuestions = _bloc.authQuestions;
    }
    if (newIndex == 1) {
      nextIndex = 1;
      _bloc.add(DelegatedOnTapStepEvent(id: newIndex));
    } else if (newIndex == 2) {
      if (_currentIndex == 1) {
        nextIndex = 2;
        _onSaveOwnerData();
      } else if (_currentIndex != newIndex) {
        _bloc.add(DelegatedOnTapStepEvent(id: newIndex));
      }
    } else if (newIndex == 3) {
      nextIndex = 3;
      /*if (_currentIndex == 1) {
        _onSaveOwnerData();
      } else*/
      if (_currentIndex == 2) {
        _onSaveAuthData();
      } else {
        _bloc.add(DelegatedOnTapStepEvent(id: newIndex));
      }
    }
  }

  void _showSignatureBottomSheetWidget() {
    FocusScope.of(context).unfocus();
    showBottomSheetWidget(
      context: context,
      content: SignatureWidget(
        onTapSaveSignature: (bytes) {
          if (_currentIndex == 1) {
            if (bytes != null) {
              _signatureImage = bytes;
              _signatureImageNetwork = "";
            } else {
              // _signatureImage = null;
            }
            _bloc.add(ValidateSignatureEvent(_signatureImage));
          } else {
            if (bytes != null) {
              _authSignatureImage = bytes;
              _authSignatureImageNetwork = "";
              _bloc.add(AuthSaveSignatureEvent(bytes));
            } else {
              // _authSignatureImage = Uint8List.fromList([]);
            }
          }
          _popBack();
        },
        onTapClearSignature: () {
          _bloc.add(ClearSignatureEvent());
        },
        signatureImage:
            _currentIndex == 1 ? _signatureImage : _authSignatureImage,
        signatureImageNetwork: _currentIndex == 1
            ? _signatureImageNetwork
            : _authSignatureImageNetwork,
        isNetworkImage: (_currentIndex == 1 && _signatureImageNetwork != "") ||
            (_currentIndex == 2 && _authSignatureImageNetwork != ""),
      ),
      titleLabel: S.of(context).signature,
      height: 380,
    );
  }

  void showMediaBottomSheet({required PageField question}) {
    FocusScope.of(context).unfocus();
    showBottomSheetUploadMedia(
      context: context,
      onTapCamera: () async {
        _popBack();
        if (await PermissionServiceHandler().handleServicePermission(
            setting: PermissionServiceHandler.getCameraPermission())) {
          _getImage(ImageSource.camera, question);
        } else {
          _showActionDialogWidget(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _popBack();
              openAppSettings();
            },
            onSecondaryAction: () {
              _popBack();
            },
            primaryText: S.current.ok,
            secondaryText: S.current.cancel,
            text: S.current.youShouldHaveCameraPermission,
          );
        }
      },
      onTapGallery: () async {
        _popBack();

        if (await PermissionServiceHandler().handleServicePermission(
            setting:
                PermissionServiceHandler.getSingleImageGalleryPermission())) {
          _getImage(ImageSource.gallery, question);
        } else {
          _showActionDialogWidget(
            icon: ImagePaths.warning,
            onPrimaryAction: () {
              _popBack();
              openAppSettings().then((value) async {
                if (await PermissionServiceHandler().handleServicePermission(
                    setting: PermissionServiceHandler
                        .getSingleImageGalleryPermission())) {}
              });
            },
            onSecondaryAction: () {
              _popBack();
            },
            primaryText: S.current.ok,
            secondaryText: S.current.cancel,
            text: Platform.isIOS
                ? S.current.youShouldHaveStoragePermission
                : S.current.youShouldHaveCameraPermission,
          );
        }
      },
    );
  }

  Future<void> _getImage(ImageSource img, PageField question) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: img);
    XFile? imageFile = pickedFile;
    if (imageFile != null) {
      XFile? compressedImage = await compressFile(File(imageFile.path));
      if (compressedImage != null) {
        if (_currentIndex == 1) {
          _bloc.add(SelectDynamicImageEvent(
              xFile: compressedImage, question: question));
        } else {
          _bloc.add(AuthSelectDynamicImageEvent(
              xFile: compressedImage, question: question));
        }
      }
    }
  }

  void _onSaveOwnerData() {
    FocusScope.of(context).unfocus();
    if (_dateFrom == null) {
      _bloc.add(DelegatedValidateDateFromEvent(
          englishNumbers(_dateFromController.text)));
    }
    if (_dateTo == null) {
      _bloc.add(
          DelegatedValidateDateToEvent(englishNumbers(_dateToController.text)));
    }
    _bloc.add(OnOwnerSaveEvent(
        message: _messageController.text,
        id: _idController.text,
        dateFrom: englishNumbers(_dateFromController.text),
        dateTo: englishNumbers(_dateToController.text),
        imagePath:
            _selectedImage == null ? _selectedImageNetwork : _selectedImage!,
        signature: _signatureImage == null
            ? _signatureImageNetwork
            : _signatureImage.toString(),
        questions: _bloc.ownerQuestions));
  }

  void _onSaveAuthData() {
    FocusScope.of(context).unfocus();

    _bloc.add(OnAuthorizedSaveEvent(
        id: _authIdController.text,
        name: _authNameController.text,
        mobileNo: _authMobileNumberController.text,
        imagePath: _authSelectedImage == null
            ? _authSelectedImageNetwork
            : _authSelectedImage!,
        questions: _bloc.authQuestions,
        countryCode: _authCountryCode));
  }

  void _openSearchableBottomSheet(PageField question, bool isMultiChoice) {
    showSearchableBottomSheet(
      context: context,
      pageField: question,
      isMultiChoice: isMultiChoice,
      onSaveMultiChoice: (pageField, choices) {
        if (_currentIndex == 1) {
          _bloc.add(OwnerUpdateSearchableMultiQuestionEvent(
              question: pageField, answer: choices));
        } else {
          _bloc.add(AuthUpdateSearchableMultiQuestionEvent(
              question: pageField, answer: choices));
        }
      },
      onChoicesSelected: (pageField, choice) {
        if (_currentIndex == 1) {
          _bloc.add(OwnerUpdateSearchableSingleQuestionEvent(
              question: pageField, answer: choice));
        } else {
          _bloc.add(AuthUpdateSearchableSingleQuestionEvent(
              question: pageField, answer: choice));
        }
        _popBack();
      },
    );
  }

  void _submitDelegation() {
    SubmitDelegatedRequest submitDelegatedRequest = SubmitDelegatedRequest(
      id: widget.isEdit ? widget.delegatedData.id : 0,
      notes: _messageController.text.toString(),
      name: _nameController.text.toString(),
      personalID: _idController.text.toString(),
      fromDate: englishNumbers(_dateFromController.text.toString()),
      toDate: englishNumbers(_dateToController.text.toString()),
      authName: _authNameController.text.toString(),
      authPersonalID: _authIdController.text.toString(),
      authMobile: _authMobileNumberController.text.toString(),
      statusId: widget.isEdit ? widget.delegatedData.statusId : 1,
      authCountryCode: _authCountryCode,
      ownerExtraField: _ownerQuestions.mapToDelegatedExtraFieldRequest(),
      authExtraField: _authQuestions.mapToDelegatedExtraFieldRequest(),
    );

    _bloc.add(SubmitDelegationEvent(
      ownerIdPath: _selectedImage ?? "",
      authIdPath: _authSelectedImage ?? "",
      ownerSignaturePath: _signatureImage ?? Uint8List.fromList([]),
      authSignaturePath: _authSignatureImage ?? Uint8List.fromList([]),
      submitDelegatedRequest: submitDelegatedRequest,
    ));
  }

  void screenPopBack() {
    if (isUnsavedChangedDate) {
      shouldPop = false;
      _showActionDialogWidget(
          icon: ImagePaths.warning,
          text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
          primaryText: S.of(context).keep,
          secondaryText: S.of(context).discard,
          onPrimaryAction: () {
            shouldPop = false;
            _popBack();
          },
          onSecondaryAction: () {
            checkBackDestination();
            _popBack();
          });
    } else {
      if (_currentIndex == 3) {
        shouldPop = false;
        _currentIndex = 1;
        _pageController.jumpToPage(_currentIndex - 1);
        BlocProvider.of<DelegatedBloc>(context).isReloadList = true;
        Navigator.pop(context, Routes.delegated);
      } else {
        checkBackDestination();
      }
    }
  }

  void checkBackDestination() {
    if (_currentIndex == 1) {
      shouldPop = false;
      _popBack();
    } else if (_currentIndex == 2) {
      shouldPop = false;
      _onTapStep(1);
    } else if (_currentIndex == 3) {
      shouldPop = false;
      _currentIndex = 1;
      _pageController.jumpToPage(_currentIndex - 1);
      BlocProvider.of<DelegatedBloc>(context).isReloadList = true;
      Navigator.pop(context, Routes.delegated);
    } else {
      shouldPop = true;
      _popBack();
    }
  }

  Future<void> _scrollTo() async {
    await Future.delayed(const Duration(milliseconds: 100));
    scrollTo();
  }

  void scrollTo() {
    if (_idErrorMessage != null) {
      Scrollable.ensureVisible(idKey.currentContext!);
    } else if (_messageErrorMessage != null) {
      Scrollable.ensureVisible(messageKey.currentContext!);
    } else if (_selectImageErrorMessage != null) {
      Scrollable.ensureVisible(imageKey.currentContext!);
    } else if (_signatureErrorMessage != null) {
      Scrollable.ensureVisible(captureSignatureKey.currentContext!);
    } else if (_dateFromErrorMessage != null || _dateToErrorMessage != null) {
      Scrollable.ensureVisible(dateKey.currentContext!);
    } else {
      if (scrollKey != null) {
        Scrollable.ensureVisible(scrollKey!);
      }
    }
  }

  Future<void> _authScrollTo() async {
    await Future.delayed(const Duration(milliseconds: 100));
    authScrollTo();
  }

  void authScrollTo() {
    if (_authNameErrorMessage != null) {
      Scrollable.ensureVisible(authNameKey.currentContext!);
    } else if (_authIdErrorMessage != null) {
      Scrollable.ensureVisible(authIdKey.currentContext!);
    } else if (_authMobileNumberErrorMessage != null) {
      Scrollable.ensureVisible(authMobileKey.currentContext!);
    } else if (_authSelectImageErrorMessage != null) {
      Scrollable.ensureVisible(authImageKey.currentContext!);
    } else {
      if (authScrollKey != null) {
        Scrollable.ensureVisible(authScrollKey!);
      }
    }
  }

  void _onTapImagePreview(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }
}
