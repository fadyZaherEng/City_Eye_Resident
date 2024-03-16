import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/request/add_contact_us_request.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:city_eye/src/presentation/blocs/contact_us/contact_us_bloc.dart';
import 'package:city_eye/src/presentation/screens/contact_us/utils/show_country_bottom_sheet.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_text_field_with_suffix_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUsScreen extends BaseStatefulWidget {
  const ContactUsScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends BaseState<ContactUsScreen> {
  ContactUsBloc get _bloc => BlocProvider.of<ContactUsBloc>(context);

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var mobileNoController = TextEditingController();
  var countryController = TextEditingController();
  var messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _focus = FocusNode();
  bool _textFieldHasFocus = false;

  @override
  void initState() {
    _focus.addListener(() {
      setState(() {
        _textFieldHasFocus = _focus.hasFocus;
      });
    });
    super.initState();
  }

  List<Country> countries = [];

  Country selectedCountry = const Country();

  String? _nameErrorMessage;
  String? _emailAddressErrorMessage;
  String? _mobileNumberErrorMessage;
  String? _countryErrorMessage;
  String _messageErrorMessage = "";
  int minimumCharacters = 30;

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSchemes.white,
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).requestNow,
        isHaveBackButton: true,
        onBackButtonPressed: () {
          _navigateBackEvent();
        },
        backgroundColor: ColorSchemes.white,
      ),
      body: BlocConsumer<ContactUsBloc, ContactUsState>(
        listener: (mContext, state) {
          if (state is ShowLoadingState) {
            showLoading();
          } else if (state is HideLoadingState) {
            hideLoading();
          } else if (state is SuccessFetchCountriesState) {
            countries = state.countries;
            _openBottomSheet(context);
          } else if (state is ErrorFetchCountriesState) {
            showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.error,
              buttonText: S.of(context).ok,
              onTap: () => _navigateBackEvent(),
            );
          } else if (state is NavigateBackState) {
            Navigator.pop(context);
          } else if (state is ErrorContactUsSendState) {
            showMassageDialogWidget(
              context: context,
              text: state.status,
              icon: ImagePaths.error,
              buttonText: S.of(context).ok,
              onTap: () => _navigateBackEvent(),
            );
          } else if (state is SuccessContactUsSendState) {
            _bloc.add(DisplayDialogWhenSuccessAddContactUsEvent(state.status));
          } else if (state is DisplayDialogWhenSuccessAddContactUsState) {
            showMassageDialogWidget(
              context: context,
              text: state.message,
              icon: ImagePaths.success,
              buttonText: S.of(context).ok,
              onTap: () => _navigateBackForClearDataFieldEvent(),
            );
          } else if (state is NavigateBackForClearDataState) {
            _navigateBackEvent();
            _clearContactUsDataFieldsEvent();
            _navigateBackEvent();
          } else if (state is ClearContactUsDataFieldsState) {
            _clearDataField();
          } else if (state is OpenCountryBottomSheetState) {
            _bloc.add(FetchCountriesEvent());
          } else if (state is SetCountryState) {
            countryController.text = state.countryName;
            _bloc.add(
                ValidateCountryEvent(state.countryName, state.countryCode));
          } else if (state is ValidateUsernameState) {
            _nameErrorMessage = null;
          } else if (state is ValidateUsernameEmptyFormatState) {
            _scrollTo(0);
            _nameErrorMessage = state.nameValidatorMessage;
          } else if (state is ValidateEmailState) {
            _emailAddressErrorMessage = null;
          } else if (state is ValidateEmailEmptyFormatState) {
            if (_nameErrorMessage == null) _scrollTo(100);
            _emailAddressErrorMessage = state.emailValidatorMessage;
          } else if (state is ValidateMobileNumberState) {
            _mobileNumberErrorMessage = null;
          } else if (state is ValidateMobileNumberEmptyFormatState) {
            if (_nameErrorMessage == null &&
                _emailAddressErrorMessage == null) {
              _scrollTo(200);
            }
            _mobileNumberErrorMessage = state.mobileNumberValidatorMessage;
          } else if (state is ValidateCountryState) {
            _countryErrorMessage = null;
          } else if (state is ValidateCountryEmptyFormatState) {
            if (_nameErrorMessage == null &&
                _emailAddressErrorMessage == null) {
              _scrollTo(200);
            }
            _countryErrorMessage = state.countryValidatorMessage;
          } else if (state is ValidateMessageState) {
            _messageErrorMessage = "";
          } else if (state is ValidateMessageEmptyFormatState) {
            if (_nameErrorMessage == null &&
                _emailAddressErrorMessage == null) {
              _scrollTo(200);
            }
            _messageErrorMessage = state.messageValidatorMessage;
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20.0, right: 20.0),
                      child: CustomTextFieldWidget(
                        controller: nameController,
                        labelTitle: S.of(context).name,
                        onChange: (string) {
                          _bloc.add(
                              ValidateUsernameEvent(nameController.value.text));
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r' \s'),
                              replacementString: " "),
                        ],
                        errorMessage: _nameErrorMessage,
                        textInputType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20.0, right: 20.0),
                      child: CustomTextFieldWidget(
                        controller: emailController,
                        labelTitle: S.of(context).emailAddress,
                        onChange: (string) {
                          _bloc.add(
                              ValidateEmailEvent(emailController.value.text));
                        },
                        errorMessage: _emailAddressErrorMessage,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20.0, right: 20.0),
                      child: CustomTextFieldWidget(
                        controller: mobileNoController,
                        labelTitle: S.of(context).mobileNumber,
                        onChange: (string) {
                          _bloc.add(ValidateMobileNumberEvent(
                              mobileNoController.value.text));
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        errorMessage: _mobileNumberErrorMessage,
                        textInputType: TextInputType.phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20.0, right: 20.0),
                      child: CustomTextFieldWithSuffixIconWidget(
                        isReadOnly: true,
                        controller: countryController,
                        labelTitle: S.of(context).country,
                        errorMessage: _countryErrorMessage,
                        suffixIcon: SvgPicture.asset(
                          "assets/images/ic_arrowdown.svg",
                          fit: BoxFit.scaleDown,
                          matchTextDirection: true,
                        ),
                        onTap: () {
                          _openCountryBottomSheetEvent();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20.0, right: 20.0),
                      child: SizedBox(
                        height: _messageErrorMessage.isEmpty ? 100 : 120,
                        child: TextField(
                          expands: true,
                          maxLines: null,
                          textAlign: TextAlign.start,
                          maxLength: 30,
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: TextInputType.multiline,
                          controller: messageController,
                          onChanged: (string) {
                            if (string.length > 30) {
                              messageController.text = string.substring(0, 30);
                              messageController.selection =
                                  TextSelection.fromPosition(
                                      const TextPosition(offset: 30));
                            }
                            minimumCharacters =
                                30 - messageController.text.length;
                            _bloc.add(ValidateMessageEvent(
                                messageController.value.text));
                          },
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: Constants.fontWeightRegular,
                                  color: ColorSchemes.black,
                                  letterSpacing: -0.13),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.border),
                                borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.border),
                                borderRadius: BorderRadius.circular(12)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.redError),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: ColorSchemes.border),
                                borderRadius: BorderRadius.circular(12)),
                            errorText: _messageErrorMessage.isNotEmpty
                                ? _messageErrorMessage
                                : null,
                            labelText: S.of(context).message,
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 20),
                            labelStyle:
                                _labelStyle(context, _textFieldHasFocus),
                            errorMaxLines: 2,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            S.of(context).maximum,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: ColorSchemes.gray),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$minimumCharacters",
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: messageController.text.length == 30
                                        ? ColorSchemes.redError
                                        : ColorSchemes.black),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            S.of(context).characters,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: ColorSchemes.gray),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: CustomButtonWidget(
                        onTap: () {
                          _bloc.add(ContactUsSendEvent(
                            AddContactUsRequest(
                              name: nameController.value.text,
                              email: emailController.value.text,
                              mobile: mobileNoController.value.text,
                              countryId: selectedCountry.id,
                              message: messageController.value.text,
                            ),
                            countryController.value.text.toString(),
                          ));
                        },
                        width: double.infinity,
                        text: S.of(context).send,
                        backgroundColor: F.isNiceTouch
                            ? ColorSchemes.ghadeerDarkBlue
                            : ColorSchemes.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showCountryBottomSheet(
        context: context,
        height: 400,
        countries: countries,
        selectedCountry: selectedCountry,
        onCountrySelected: (country) {
          // _navigateBackEvent();
          if (country.code == selectedCountry.code) return;
          selectedCountry = country;
          _bloc.add(
            SetCountryEvent(
              countryCode: selectedCountry.code,
              countryName: selectedCountry.name,
            ),
          );
          _navigateBackEvent();
        });
  }

  void _openCountryBottomSheetEvent() {
    _bloc.add(OpenCountryBottomSheetEvent());
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  void _navigateBackForClearDataFieldEvent() {
    _bloc.add(NavigateBackForClearDataEvent());
  }

  void _clearContactUsDataFieldsEvent() {
    _bloc.add(ClearContactUsDataFieldsEvent());
  }

  void _clearDataField() {
    nameController.clear();
    emailController.clear();
    mobileNoController.clear();
    countryController.clear();
    messageController.clear();
  }

  void _scrollTo(double position) {
    _scrollController.animateTo(
      // desired position in pixels
      position,
      // duration of the scroll animation
      duration: const Duration(milliseconds: 300),
      // curve for the animation (optional)
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  TextStyle _labelStyle(BuildContext context, bool hasFocus) {
    if (hasFocus || messageController.text.isNotEmpty) {
      return Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: _messageErrorMessage.isEmpty
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    } else {
      return Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: Constants.fontWeightRegular,
            color: _messageErrorMessage.isEmpty
                ? ColorSchemes.gray
                : ColorSchemes.redError,
            letterSpacing: -0.13,
          );
    }
  }
}
