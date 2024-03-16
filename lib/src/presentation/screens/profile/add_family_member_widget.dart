import 'dart:async';
import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:city_eye/src/core/utils/is_url.dart';
import 'package:city_eye/src/core/utils/permission_service_handler.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet_upload_media.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/add_user_family_member_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/request/update_user_family_member_request.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/profile/family_member.dart';
import 'package:city_eye/src/domain/entities/profile/family_member_type.dart';
import 'package:city_eye/src/domain/entities/profile/type_model.dart';
import 'package:city_eye/src/domain/usecase/get_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_language_use_case.dart';
import 'package:city_eye/src/presentation/blocs/add_family_member/add_family_bloc.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_border_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_mobile_number_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';

class AddFamilyMemberWidget extends BaseStatefulWidget {
  final bool isUpdate;
  final FamilyMember? familyMember;
  final List<FamilyMemberType> familyMembersTypes;
  final Function(List<FamilyMember>) isUpdateFamilyMemberList;

  const AddFamilyMemberWidget({
    Key? key,
    this.isUpdate = false,
    this.familyMember,
    required this.familyMembersTypes,
    required this.isUpdateFamilyMemberList,
  }) : super(key: key);

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends BaseState<AddFamilyMemberWidget> {
  AddFamilyBloc get _bloc => BlocProvider.of<AddFamilyBloc>(context);

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? nameErrorMessage;
  String? mobileNumberErrorMessage;
  String? familyMemberTypeErrorMessage;
  String? emailErrorMessage;
  FamilyMember? _familyMember;
  List<FamilyMemberType> _familyMembersTypes = [];

  int indexToScrollTo = 0;

  String countryCode = "EG";
  bool isNetwork = false;
  String selectedImage = "";
  String? selectImageErrorMessage;

  GlobalKey nameKey = GlobalKey();
  GlobalKey mobileNumberKey = GlobalKey();
  GlobalKey emailKey = GlobalKey();
  GlobalKey imageKey = GlobalKey();
  GlobalKey familyMemberTypeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.familyMember != null) {
      countryCode = widget.familyMember!.countryCode;
    } else {
      countryCode = GetCurrentCountryCodeUseCase(injector())();
    }
    _initializeAddFamilyEvent(
      widget.familyMember,
      widget.familyMembersTypes.toList(),
    );
  }

  void _initializeAddFamilyEvent(
    FamilyMember? familyMember,
    List<FamilyMemberType> familyMembersTypes,
  ) {
    _bloc.add(InitializeAddFamilyMemberEvent(
      familyMember: familyMember,
      familyMembersTypes: familyMembersTypes,
    ));
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<AddFamilyBloc, AddFamilyState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is InitializeAddFamilyMemberState) {
          _familyMember = state.familyMember;
          _familyMembersTypes = state.familyMemberTypes;
          _nameController.text = _familyMember?.name ?? "";
          _mobileNumberController.text = _familyMember?.mobileNumber ?? "";
          _emailController.text = _familyMember?.email ?? "";
          countryCode = _familyMember?.countryCode ??
              GetCurrentCountryCodeUseCase(injector())();

          _bloc.isValidMobileNumber =
              _familyMember?.mobileNumber.isNotEmpty ?? false;

          isNetwork = isUrl(_familyMember?.attachment ?? "");

          if (widget.isUpdate) {
            for (var element in _familyMembersTypes) {
              indexToScrollTo++;
              if (element.id == _familyMember!.familyMemberType.id) {
                element.copyWith(
                  isSelected: true,
                );
                _scrollToElement(indexToScrollTo);
                break;
              }
            }
          }
        } else if (state is SelectFamilyRelationState) {
          _familyMembersTypes = state.familyMemberTypes;
        } else if (state is NavigateBackState) {
          _navigateBack(arguments: state.arguments);
        } else if (state is NameValidState) {
          nameErrorMessage = null;
        } else if (state is NameInvalidState) {
          nameErrorMessage = state.errorMessage;
        } else if (state is EmailValidState) {
          emailErrorMessage = null;
        } else if (state is EmailInvalidState) {
          emailErrorMessage = state.errorMessage;
        } else if (state is MobileNumberValidState) {
          mobileNumberErrorMessage = null;
          countryCode = state.countryCode;
        } else if (state is MobileNumberInvalidState) {
          mobileNumberErrorMessage = state.errorMessage;
        } else if (state is FamilyMemberTypeValidState) {
          familyMemberTypeErrorMessage = null;
        } else if (state is FamilyMemberTypeInvalidState) {
          familyMemberTypeErrorMessage = state.errorMessage;
        } else if (state is ValidAddFamilyFormState) {
          FamilyMemberType familyMemberType =
              const FamilyMemberType(id: 0, name: "");
          for (int index = 0; index < _familyMembersTypes.length; index++) {
            if (_familyMembersTypes[index].isSelected) {
              familyMemberType = _familyMembersTypes[index];
            }
          }
          if (!widget.isUpdate) {
            _addFamilyMemberEvent(
              FamilyMember(
                name: state.name,
                mobileNumber: state.mobileNumber,
                familyMemberType: TypeModel(
                  id: familyMemberType.id,
                  name: familyMemberType.name,
                ),
                email: state.email,
                attachment: selectedImage,
                countryCode: state.countryCode,
              ),
            );
          } else {
            _updateFamilyMemberEvent(
              FamilyMember(
                name: state.name,
                mobileNumber: state.mobileNumber,
                familyMemberType: TypeModel(
                  id: familyMemberType.id,
                  name: familyMemberType.name,
                ),
                email: state.email,
                attachment: selectedImage,
                countryCode: state.countryCode,
              ),
            );
          }
        } else if (state is AddFamilyMemberSuccessState) {
          widget.isUpdateFamilyMemberList(state.familyMembersList);
          _navigateBackEvent();
          _onShareClicked(
              invitationUrl: state.invitation.invitationUrl,
              otpNumber: state.invitation.otpNumber);
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
        } else if (state is AddFamilyMemberErrorState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is UpdateFamilyMemberSuccessState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarSuccess,
            icon: ImagePaths.success,
          );
          widget.isUpdateFamilyMemberList(state.familyMembersList);
          _navigateBackEvent();
        } else if (state is UpdateFamilyMemberErrorState) {
          showSnackBar(
            context: context,
            message: state.message,
            color: ColorSchemes.snackBarError,
            icon: ImagePaths.error,
          );
        } else if (state is ImageSelectionValidState) {
          selectImageErrorMessage = null;
          selectedImage = state.imagePath;
          isNetwork = false;
        } else if (state is ImageSelectionInvalidState) {
          selectImageErrorMessage = state.errorMessage;
        } else if (state is ScrollToItemState) {
          _scrollToInvalid();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: () async {
              if (widget.familyMember == null &&
                  (_nameController.text.toString().trim().isNotEmpty ||
                      _mobileNumberController.text
                          .toString()
                          .trim()
                          .isNotEmpty ||
                      _familyMembersTypes
                          .any((element) => element.isSelected) ||
                      _emailController.text.toString().trim().isNotEmpty ||
                      selectedImage.isNotEmpty)) {
                _showActionDialog(
                  icon: ImagePaths.warning,
                  text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
                  primaryText: S.of(context).keep,
                  onPrimaryAction: () {
                    _navigateBackEvent();
                  },
                  secondaryText: S.of(context).discard,
                  onSecondaryAction: () {
                    _navigateBackEvent();
                    _navigateBackEvent();
                  },
                );
                return false;
              } else if (widget.familyMember != null &&
                  (widget.familyMember!.name !=
                          _nameController.text.trim().toString() ||
                      widget.familyMember!.mobileNumber !=
                          _mobileNumberController.text.trim().toString() ||
                      widget.familyMember!.familyMemberType.id !=
                          ((_familyMembersTypes.firstWhere(
                              (element) => element.isSelected)).id))) {
                _showActionDialog(
                  icon: ImagePaths.warning,
                  text: S.of(context).allChangesWillBeLostIfYouLeaveThisPage,
                  primaryText: S.of(context).keep,
                  onPrimaryAction: () {
                    _navigateBackEvent();
                  },
                  secondaryText: S.of(context).discard,
                  onSecondaryAction: () {
                    _navigateBackEvent();
                    _navigateBackEvent();
                  },
                );
                return false;
              } else {
                _navigateBackEvent();
              }
              return false;
            },
            child: GestureDetector(
              onTap: () {
                _loseFocus(context);
              },
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        CustomTextFieldWidget(
                          key: nameKey,
                          controller: _nameController,
                          labelTitle: S.of(context).name,
                          onChange: (value) {
                            _bloc.add(ValidateNameEvent(name: value));
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r' \s'),
                                replacementString: " "),
                          ],
                          errorMessage: nameErrorMessage,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
                        CustomMobileNumberWidget(
                          key: mobileNumberKey,
                          initialValue: widget.familyMember?.mobileNumber ?? "",
                          onChange: (number, code) {
                            _mobileNumberController.text = number.toString();
                            _bloc.add(ValidateMobileNumberEvent(
                                mobileNumber: number, regionCode: code));
                          },
                          controller: _mobileNumberController,
                          labelTitle: S.of(context).mobileNumber,
                          errorMessage: mobileNumberErrorMessage,
                          countryCode: countryCode,
                          languageCode: GetLanguageUseCase(injector())(),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldWidget(
                          key: emailKey,
                          controller: _emailController,
                          labelTitle: S.of(context).emailAddress,
                          onChange: (value) {
                            _bloc.add(
                                ValidateEmailAddressEvent(emailAddress: value));
                          },
                          errorMessage: emailErrorMessage,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        (selectedImage == "" && !isNetwork)
                            ? GestureDetector(
                                onTap: () {
                                  _uploadMediaBottomSheet();
                                },
                                child: DottedBorder(
                                  color: selectImageErrorMessage == null
                                      ? ColorSchemes.primary
                                      : ColorSchemes.redError,
                                  borderType: BorderType.RRect,
                                  strokeWidth: 1,
                                  radius: const Radius.circular(8),
                                  child: SizedBox(
                                    key: imageKey,
                                    height: 130,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 24.0),
                                        SvgPicture.asset(
                                            ImagePaths.uploadImagePlaceholder),
                                        const SizedBox(height: 16.0),
                                        Text(
                                          S.of(context).uploadYourId,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  color: ColorSchemes.gray,
                                                  letterSpacing: -0.13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _onTapPreviewImage(isNetwork
                                          ? _familyMember?.attachment ?? ""
                                          : selectedImage);
                                    },
                                    child: SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: isNetwork
                                                ? Image.network(
                                                    _familyMember?.attachment ??
                                                        "",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        _buildPlaceHolderImage(),
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return SizedBox(
                                                        width: double.infinity,
                                                        height: 200,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: ColorSchemes
                                                                .primary,
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : SizedBox(
                                                    child: Image.file(
                                                        File(selectedImage),
                                                        fit: BoxFit.cover),
                                                  ))),
                                  ),
                                  Positioned.directional(
                                    textDirection: Directionality.of(context),
                                    end: 6,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5),
                                        InkWell(
                                          onTap: () {
                                            selectedImage = "";
                                            _bloc.add(
                                                const ValidateImageSelectionEvent(
                                                    imagePath: ""));
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: const BoxDecoration(
                                              color: ColorSchemes.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                              ImagePaths.close,
                                              fit: BoxFit.scaleDown,
                                              color: ColorSchemes.gray,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        InkWell(
                                          onTap: () {
                                            _uploadMediaBottomSheet();
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: const BoxDecoration(
                                              color: ColorSchemes.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                              ImagePaths.edit,
                                              fit: BoxFit.scaleDown,
                                              color: ColorSchemes.gray,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: selectImageErrorMessage != null,
                          child: Text(
                            "* ${S.of(context).thisImageRequired}",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: ColorSchemes.redError,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          key: familyMemberTypeKey,
                          S.of(context).relationship,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: ColorSchemes.black,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 35,
                          child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: _familyMembersTypes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 10,
                                  ),
                                  child: CustomButtonBorderWidget(
                                    onTap: () {
                                      _loseFocus(context);
                                      _bloc.add(SelectFamilyRelationEvent(
                                        familyMemberTypes: _familyMembersTypes,
                                        selectedFamilyMemberType:
                                            _familyMembersTypes[index],
                                      ));
                                    },
                                    buttonTitle:
                                        _familyMembersTypes[index].name,
                                    isSelected:
                                        _familyMembersTypes[index].isSelected,
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildErrorWidget(
                          familyMemberTypeErrorMessage ?? "",
                        ),
                        const Expanded(
                            child: SizedBox(
                          height: 32,
                        )),
                        CustomButtonWidget(
                          width: double.infinity,
                          onTap: () {
                            _loseFocus(context);
                            _bloc.add(ValidateFamilyMemberFormEvent(
                              name: _nameController.text,
                              mobileNumber: _mobileNumberController.text,
                              familyMemberTypes: _familyMembersTypes,
                              emailAddress: _emailController.text,
                              imagePath: isNetwork
                                  ? _familyMember?.attachment ?? ""
                                  : selectedImage,
                              countryCode: countryCode,
                            ));
                          },
                          text: widget.familyMember == null
                              ? S.of(context).save
                              : S.of(context).update,
                          backgroundColor: F.isNiceTouch
                              ? ColorSchemes.ghadeerDarkBlue
                              : ColorSchemes.primary,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _loseFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void _addFamilyMemberEvent(FamilyMember familyMember) {
    AddUserFamilyMemberRequest request = AddUserFamilyMemberRequest(
      name: _nameController.text.trim(),
      mobileNumber: _mobileNumberController.text.trim(),
      relationShipTypeId: familyMember.familyMemberType.id,
      countryCode: countryCode,
      email: _emailController.text.trim(),
      attachment: "",
    );

    _bloc.add(AddFamilyMemberEvent(
      request: request,
      imagePath: selectedImage,
    ));
  }

  void _updateFamilyMemberEvent(FamilyMember familyMember) {
    UpdateUserFamilyMemberRequest request = UpdateUserFamilyMemberRequest(
      id: widget.familyMember!.id,
      name: _nameController.text.trim(),
      mobileNumber: _mobileNumberController.text.trim(),
      relationShipTypeId: familyMember.familyMemberType.id,
      countryCode: countryCode,
      email: _emailController.text.trim(),
      attachment: widget.familyMember!.attachment,
    );

    _bloc.add(UpdateFamilyMemberEvent(
      request: request,
      imagePath: selectedImage,
    ));
  }

  void _navigateBack({Map<String, dynamic>? arguments}) {
    Navigator.pop(context, arguments);
  }

  void _navigateBackEvent({Map<String, dynamic>? arguments}) {
    _bloc.add(NavigateBackEvent(arguments: arguments));
  }

  void _showActionDialog({
    required Function() onPrimaryAction,
    required Function() onSecondaryAction,
    required String primaryText,
    required String secondaryText,
    required String text,
    required String icon,
  }) {
    _loseFocus(context);
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
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () {
        onTap();
      },
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Visibility(
      visible: errorMessage.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorSchemes.redError,
                ),
          ),
        ],
      ),
    );
  }

  void _uploadMediaBottomSheet() {
    FocusScope.of(context).unfocus();
    showBottomSheetUploadMedia(
        context: context,
        onTapCamera: () async {
          _navigateBackEvent();
          if (await PermissionServiceHandler().handleServicePermission(
              setting: PermissionServiceHandler.getCameraPermission())) {
            _selectImage(true);
          } else {
            _showActionDialogWidget(
              icon: ImagePaths.warning,
              onPrimaryAction: () {
                _navigateBackEvent();
                openAppSettings();
              },
              onSecondaryAction: () {
                _navigateBackEvent();
              },
              primaryText: S.current.ok,
              secondaryText: S.current.cancel,
              text: S.current.youShouldHaveCameraPermission,
            );
          }
        },
        onTapGallery: () async {
          _navigateBackEvent();
          if (await PermissionServiceHandler().handleServicePermission(
              setting: PermissionServiceHandler.getCameraPermission())) {
            _selectImage(false);
          } else {
            _showActionDialogWidget(
              icon: ImagePaths.warning,
              onPrimaryAction: () {
                _navigateBackEvent();
                openAppSettings().then((value) async {
                  if (await PermissionServiceHandler().handleServicePermission(
                      setting:
                          PermissionServiceHandler.getCameraPermission())) {}
                });
              },
              onSecondaryAction: () {
                _navigateBackEvent();
              },
              primaryText: S.current.ok,
              secondaryText: S.current.cancel,
              text: S.current.youShouldHaveCameraPermission,
            );
          }
        });
  }

  Future<void> _selectImage(bool isCamera) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile != null) {
      XFile? file = await compressFile(File(pickedFile.path));
      if (file != null) {
        _bloc.add(ValidateImageSelectionEvent(imagePath: file.path));
      }
    } else {
      _bloc.add(const ValidateImageSelectionEvent(imagePath: ""));
    }
  }

  void _showActionDialogWidget(
      {required String text,
      required String icon,
      required String primaryText,
      required String secondaryText,
      required Function() onPrimaryAction,
      required Function() onSecondaryAction}) {
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

  void _scrollToElement(int index) {
    _scrollController.animateTo(
      index * 35,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linearToEaseOut,
    );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }

  Future<void> _scrollToInvalid() async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (nameErrorMessage != null) {
      Scrollable.ensureVisible(
        nameKey.currentContext ?? context,
        duration: const Duration(milliseconds: 500),
      );
    } else if (mobileNumberErrorMessage != null) {
      Scrollable.ensureVisible(
        mobileNumberKey.currentContext ?? context,
        duration: const Duration(milliseconds: 500),
      );
    } else if (emailErrorMessage != null) {
      Scrollable.ensureVisible(
        emailKey.currentContext ?? context,
        duration: const Duration(milliseconds: 500),
      );
    } else if (selectImageErrorMessage != null) {
      Scrollable.ensureVisible(
        imageKey.currentContext ?? context,
        duration: const Duration(milliseconds: 500),
      );
    } else if (familyMemberTypeErrorMessage != null) {
      Scrollable.ensureVisible(
        familyMemberTypeKey.currentContext ?? context,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  void launchWhatsApp(String phoneNumber, String message) async {
    String whatsappUrl =
        "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";
    try {
      await launchUrlString(whatsappUrl);
    } catch (e) {
      if (Platform.isAndroid) {
        String url =
            "https://play.google.com/store/apps/details?id=com.whatsapp";
        await launch(url);
      } else if (Platform.isIOS) {
        String url =
            "https://apps.apple.com/app/whatsapp-messenger/id310633997";
        await launch(url);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to open what's app"),
            ),
          );
        }
      }
    }
  }

  void _onTapPreviewImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }

  bool isDebouncing = false;

  void _onShareClicked({
    required String invitationUrl,
    required String otpNumber,
  }) async {
    String sharedText = "$invitationUrl \n $otpNumber";
    await Share.share(sharedText);
  }
}
