import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_bottom_sheet.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/compound_social_media.dart';
import 'package:city_eye/src/domain/entities/settings/page_section.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/presentation/blocs/more/more_bloc.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/widget/compounds_bottom_sheet_widget.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/more_header_widget.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/more_item_divider.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/more_item_widget.dart';
import 'package:city_eye/src/presentation/screens/more/widgets/social_media_widget.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreScreen extends BaseStatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  BaseState<MoreScreen> baseCreateState() => _MoreScreenState();
}

class _MoreScreenState extends BaseState<MoreScreen> {
  MoreBloc get _bloc => BlocProvider.of<MoreBloc>(context);
  User _user = const User();
  UserUnit _userUnit = const UserUnit();
  CompoundConfiguration _compoundConfiguration = const CompoundConfiguration();
  PageSection _pageSection = const PageSection();
  List<UserUnit> _userUnits = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetUserInformationEvent());
    _bloc.add(GetUserUnitsEvent(
      isRefresh: false,
    ));
    _bloc.add(GetCompoundConfigurationEvent());
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<MoreBloc, MoreState>(
      listener: (context, state) async {
        if (state is ShowLoadingState) {
        } else if (state is HideLoadingState) {
        } else if (state is NavigateBackState) {
          Navigator.pop(context);
        } else if (state is GetUserInformationState) {
          _user = state.user;
          _userUnit = state.userUnit;
        } else if (state is NavigateToProfileScreenState) {
          Navigator.pushNamed(context, Routes.profile, arguments: {
            "index": 1,
            "scrollToId": -1,
          }).then((value) {
            _bloc.add(GetUserInformationEvent());
          });
        } else if (state is NavigateToGalleryScreenState) {
          Navigator.pushNamed(context, Routes.gallery);
        } else if (state is NavigateToCommunityScreenState) {
          Navigator.pushNamed(context, Routes.communityRequest);
        } else if (state is NavigateToCompoundRulesScreenState) {
          Navigator.pushNamed(context, Routes.webContent, arguments: {
            "screenTitle": S.of(context).compoundRules,
            "content": _compoundConfiguration.compoundSetting.communityRules,
          });
        } else if (state is NavigateToTermsAndConditionsScreenState) {
          Navigator.pushNamed(context, Routes.webContent, arguments: {
            "screenTitle": S.of(context).termsAndConditions,
            "content": _compoundConfiguration.compoundSetting.termsConditions,
          });
        } else if (state is NavigateToAboutUsScreenState) {
          Navigator.pushNamed(context, Routes.webContent, arguments: {
            "screenTitle": S.of(context).aboutUs,
            "content": _compoundConfiguration.compoundSetting.aboutUs,
          });
        } else if (state is NavigateToStuffScreenState) {
          Navigator.pushNamed(context, Routes.stuff);
        } else if (state is NavigateToFAQScreenState) {
          Navigator.pushNamed(context, Routes.webContent, arguments: {
            "screenTitle": S.of(context).faq,
            "content": _compoundConfiguration.compoundSetting.faq,
          });
        } else if (state is NavigateToSettingsScreenState) {
          Navigator.pushNamed(context, Routes.settings);
        } else if (state is NavigateToComplainScreenState) {
          Navigator.pushNamed(context, Routes.complain);
        } else if (state is OpenWhatsAppState) {
          launchWhatsApp(state.phoneNumber);
        } else if (state is LogoutState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.landing,
            (route) => false,
          );
        } else if (state is LaunchToSocialMediaState) {
          _launchSocialMedia(
            socialMedia: state.socialMedia,
            context: context,
          );
        } else if (state is NavigateToPaymentScreenState) {
          Navigator.pushNamed(context, Routes.payment);
        } else if (state is NavigateToDelegatedScreenState) {
          Navigator.pushNamed(context, Routes.delegated);
        } else if (state is NavigateToRegisterScreenState) {
          Navigator.pushNamed(context, Routes.addUnit,
              arguments: {"userId": -1}).then((value) {
            if (value != null) {
              if ((value as bool)) {
                _bloc.add(GetUserUnitsEvent(isRefresh: true));
              }
            }
          });
        } else if (state is OpenCompoundsBottomSheetState) {
          if (state.userUnits.isNotEmpty) {
            _onOpenCompoundsBottomSheetState(
                userUnits: state.userUnits, context: context);
          }
        } else if (state is SelectCompoundState) {
          (await SharedPreferences.getInstance())
              .setBool(SharedPreferenceKeys.isRestart, true);
          _buildRestartApp(context);
        } else if (state is SwitchCompoundState) {
          (await SharedPreferences.getInstance())
              .setBool(SharedPreferenceKeys.isRestart, true);
          _buildRestartApp(context);
        } else if (state is GetCompoundConfigurationState) {
          _compoundConfiguration = state.compoundConfiguration;
          _pageSection = _compoundConfiguration.listOfPageSections
                  .where((element) => element.pageCode == "CompoundMenue")
                  .isNotEmpty
              ? _compoundConfiguration.listOfPageSections
                  .where((element) => element.pageCode == "CompoundMenue")
                  .first
              : const PageSection();
        } else if (state is GetUserUnitsSuccessState) {
          _userUnits = state.userUnits;
        } else if (state is GetUserUnitsErrorState) {
          _showMessageDialog(
            state.message,
            ImagePaths.error,
            () => Navigator.pop(context),
          );
        } else if (state is SwitchCompoundErrorState) {
          _showMessageDialog(
            state.message,
            ImagePaths.error,
            () => Navigator.pop(context),
          );
        } else if (state is NavigateToBadgeIdentityScreenState) {
          Navigator.pushNamed(context, Routes.badgeIdentity);
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: InkWell(
            onTap: () {
              _openWhatsAppEvent();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorSchemes.green,
              ),
              child: SvgPicture.asset(
                ImagePaths.whatsapp,
                height: 28,
                width: 28,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                MoreHeaderWidget(
                  user: _user,
                  userUnit: _userUnit,
                  compoundImage: getUserNextUnitsLogo(),
                  onTapSwitchAction: () {
                    _switchCompoundEvent();
                  },
                  onTapSelectCompound: () {
                    _openCompoundsBottomSheetEvent();
                  },
                  onQRTab: () {
                    _navigateToBadgeIdentityScreenEvent();
                  },
                  onTabImageProfile: (image) {
                    _onTapProfileImage(image);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                MoreItemWidget(
                  title: S.of(context).myProfile,
                  imagePath: ImagePaths.profile,
                  onTap: () {
                    _navigateToProfileScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  title: S.of(context).badgeIdentity,
                  imagePath: ImagePaths.itemUserBadge,
                  onTap: () {
                    _navigateToBadgeIdentityScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  isVisible: isItemVisible(_pageSection, "GALLERY"),
                  title: S.of(context).gallery,
                  imagePath: ImagePaths.galleryMore,
                  onTap: () {
                    _navigateToGalleryScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  isVisible: isItemVisible(_pageSection, "COMMUNITYREQUEST"),
                  title: S.of(context).communityRequest,
                  imagePath: ImagePaths.communityRequest,
                  onTap: () {
                    _navigateToCommunityScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  title: S.of(context).compoundRules,
                  imagePath: ImagePaths.compoundRules,
                  onTap: () {
                    _navigateToCompoundScreenEvent();
                  },
                ),
                const MoreItemDivider(
                  height: 4,
                  marginHorizontal: 0,
                ),
                MoreItemWidget(
                  isVisible: isItemVisible(_pageSection, "DELEGATE"),
                  title: S.of(context).delegateName,
                  imagePath: ImagePaths.delegate,
                  onTap: () {
                    _navigateToDelegatedScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  title: S.of(context).termsAndConditions,
                  imagePath: ImagePaths.termsAndConditions,
                  onTap: () {
                    _navigateToTermsAndConditionEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  title: S.of(context).aboutUs,
                  imagePath: ImagePaths.aboutUs,
                  onTap: () {
                    _navigateToAboutUsScreenEvent();
                  },
                ),
                const MoreItemDivider(
                  height: 4,
                  marginHorizontal: 0,
                ),
                MoreItemWidget(
                  isVisible: isItemVisible(_pageSection, "STAFF"),
                  title: S.of(context).staff,
                  imagePath: ImagePaths.stuff,
                  onTap: () {
                    _navigateToStuffScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  title: S.of(context).faq,
                  imagePath: ImagePaths.faq,
                  onTap: () {
                    _navigateToFAQScreenEvent();
                  },
                ),
                const MoreItemDivider(
                  height: 4,
                  marginHorizontal: 0,
                ),
                MoreItemWidget(
                  title: S.of(context).settings,
                  imagePath: ImagePaths.settings,
                  onTap: () {
                    _navigateToSettingsScreenEvent();
                  },
                ),
                const MoreItemDivider(
                  height: 4,
                  marginHorizontal: 0,
                ),
                MoreItemWidget(
                  isVisible: isItemVisible(_pageSection, "COMPLAIN"),
                  title: S.of(context).complain,
                  imagePath: ImagePaths.complain,
                  onTap: () {
                    _navigateToComplainScreenEvent();
                  },
                ),
                const MoreItemDivider(),
                MoreItemWidget(
                  isVisible: isItemVisible(_pageSection, "PAYMNET"),
                  title: S.of(context).payment,
                  imagePath: ImagePaths.payment,
                  onTap: () {
                    _navigateToPaymentScreenEvent();
                  },
                ),
                MoreItemDivider(
                  isVisible: (isItemVisible(_pageSection, "PAYMNET") ||
                      isItemVisible(_pageSection, "COMPLAIN")),
                  height: 4,
                  marginHorizontal: 0,
                ),
                const SizedBox(
                  height: 16,
                ),
                SocialMediaWidget(
                  socialMedias: _compoundConfiguration.listSocialMedia,
                  onSocialMediaTap: (CompoundSocialMedia socialMedia) {
                    _bloc.add(
                      LaunchToSocialMediaEvent(
                        socialMedia: socialMedia,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    _logoutEvent();
                  },
                  child: Text(
                    S.of(context).logout,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorSchemes.redError,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${S.of(context).poweredBy} ",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorSchemes.gray,
                            letterSpacing: -0.24,
                          ),
                    ),
                    Text(
                      F.cityEye,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: ColorSchemes.black,
                            letterSpacing: -0.24,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 41,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openCompoundsBottomSheetEvent() =>
      _bloc.add(OpenCompoundsBottomSheetEvent(
        userUnits: _userUnits,
        isRefresh: false,
      ));

  void _switchCompoundEvent() =>
      _bloc.add(SwitchCompoundEvent(userUnits: _userUnits));

  void _buildRestartApp(BuildContext context) {
    RestartWidget.restartApp(context);
  }

  Future _logoutEvent() {
    return showActionDialogWidget(
        context: context,
        text: S.of(context).areYouSureYouWantToLogOut,
        icon: ImagePaths.warning,
        primaryText: S.of(context).no,
        secondaryText: S.of(context).yes,
        primaryAction: () {
          Navigator.pop(context);
        },
        secondaryAction: () {
          _bloc.add(LogoutEvent());
        });
  }

  void _navigateToComplainScreenEvent() {
    _bloc.add(NavigateToComplainScreenEvent());
  }

  void _navigateToSettingsScreenEvent() {
    _bloc.add(NavigateToSettingsScreenEvent());
  }

  void _navigateToFAQScreenEvent() {
    _bloc.add(NavigateToFAQScreenEvent());
  }

  void _navigateToStuffScreenEvent() {
    _bloc.add(NavigateToStuffScreenEvent());
  }

  void _navigateToAboutUsScreenEvent() {
    _bloc.add(NavigateToAboutUsScreenEvent());
  }

  void _navigateToTermsAndConditionEvent() {
    _bloc.add(NavigateToTermsAndConditionsScreenEvent());
  }

  void _navigateToCompoundScreenEvent() {
    _bloc.add(NavigateToCompoundRulesScreenEvent());
  }

  void _navigateToCommunityScreenEvent() {
    _bloc.add(NavigateToCommunityScreenEvent());
  }

  void _navigateToGalleryScreenEvent() {
    _bloc.add(NavigateToGalleryScreenEvent());
  }

  void _navigateToProfileScreenEvent() {
    _bloc.add(NavigateToProfileScreenEvent());
  }

  void _openWhatsAppEvent() {
    return _bloc.add(
      OpenWhatsAppEvent(
          phoneNumber: _compoundConfiguration.compoundSetting.mobile),
    );
  }

  void _onOpenCompoundsBottomSheetState({
    required List<UserUnit> userUnits,
    required BuildContext context,
  }) {
    showBottomSheetWidget(
      context: context,
      height: _getHeight(userUnits, context),
      content: CompoundsBottomSheetWidget(
        userUnits: userUnits,
        onTapItem: (UserUnit userUnit) {
          if (userUnit.isCompoundVerified == false ||
              userUnit.isActive == false) {
            _showMessageDialog(
              userUnit.message,
              ImagePaths.error,
              () {
                Navigator.of(context).pop();
              },
            );
          } else {
            _bloc.add(
              SelectUnitEvent(
                userUnit: userUnit,
              ),
            );
          }
        },
        onTapAddAnotherUnit: () {
          Navigator.pop(context);
          _bloc.add(NavigateToRegisterScreenEvent());
        },
      ),
      titleLabel: S.of(context).selectCompound,
    ).whenComplete(
        () => _bloc.add(WhenCompletedOpenCompoundsBottomSheetEvent()));
  }

  void launchWhatsApp(String phoneNumber) async {
    String whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=";
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

  void _launchSocialMedia({
    required BuildContext context,
    required CompoundSocialMedia socialMedia,
  }) async {
    try {
      await launchUrlString(socialMedia.value);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to open ${socialMedia.socialMediaType.name}"),
        ),
      );
    }
  }

  void _navigateToPaymentScreenEvent() {
    _bloc.add(NavigateToPaymentScreenEvent());
  }

  void _navigateToDelegatedScreenEvent() {
    _bloc.add(NavigateToDelegatedScreenEvent());
  }

  bool isItemVisible(PageSection pageSection, String pageCode) {
    for (var item in pageSection.multiMediaTypes) {
      if (item.code == pageCode) {
        return item.isVisible;
      }
    }
    return false;
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
      onTap: onTap,
    );
  }

  double _getHeight(List<UserUnit> units, BuildContext context) {
    double height = 140;
    for (int i = 0; i < units.length; i++) {
      height += 95;
    }

    if (height < MediaQuery.of(context).size.height * 0.7) {
      return height;
    }
    return MediaQuery.of(context).size.height * 0.7;
  }

  String getUserNextUnitsLogo() {
    String logo = "logo";
    int currentUnitIndex =
        _userUnits.indexWhere((element) => element.isSelected);
    if (_userUnits.length > 1) {
      for (int i = currentUnitIndex + 1; i < _userUnits.length; i++) {
        if (_userUnits[i].isCompoundVerified == true &&
            _userUnits[i].isActive == true) {
          logo = _userUnits[i].compoundLogo;
          break;
        }
      }
      if (logo == "logo") {
        for (int i = 0; i < currentUnitIndex; i++) {
          if (_userUnits[i].isCompoundVerified == true &&
              _userUnits[i].isActive == true) {
            logo = _userUnits[i].compoundLogo;
            break;
          }
        }
      }
    }
    return logo == "logo" ? "" : logo;
  }

  void _navigateToBadgeIdentityScreenEvent() {
    _bloc.add(NavigateToBadgeIdentityScreenEvent());
  }

  void _onTapProfileImage(String image) {
    Navigator.pushNamed(context, Routes.galleryImages,
        arguments: GalleryImages(initialIndex: 0, images: [
          GalleryAttachment(attachment: image),
        ]));
  }
}
