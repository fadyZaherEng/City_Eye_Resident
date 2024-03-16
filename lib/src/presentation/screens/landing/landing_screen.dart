import 'dart:convert';
import 'dart:io';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/notification_services.dart';
import 'package:city_eye/src/core/utils/show_action_dialog_widget.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/entities/landing/partner.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/push_notification/firebase_notification_data.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/entities/landing/feature.dart';
import 'package:city_eye/src/domain/entities/landing/social_media.dart';
import 'package:city_eye/src/domain/usecase/save_current_country_code_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_no_internet_use_case.dart';
import 'package:city_eye/src/presentation/blocs/landing/landing_bloc.dart';
import 'package:city_eye/src/presentation/screens/landing/skeleton/skeleton_landing_screen.dart';
import 'package:city_eye/src/presentation/screens/landing/utils/show_language_bottom_sheet.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/contact_us_section.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/expandable_fab_widget.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/features_sections.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/header_section.dart';
import 'package:city_eye/src/presentation/screens/landing/widgets/partners_section.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/circular_icon.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:city_eye/src/presentation/widgets/slider_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:country_ip/country_ip.dart';

class LandingScreen extends BaseStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  BaseState<LandingScreen> baseCreateState() => _LandingScreenState();
}

class _LandingScreenState extends BaseState<LandingScreen>
    with SingleTickerProviderStateMixin {
  LandingBloc get _bloc => BlocProvider.of<LandingBloc>(context);
  List<Language> _languages = [];

  List<Feature> features = [];
  List<Partner> partners = [];

  List<SocialMedia> socialMedias = [];

  Language selectedLanguage = const Language(
    name: "",
    image: "",
    code: "",
  );

  List<Offer> _offers = [];

  @override
  void initState() {
    super.initState();
    _notificationListener();
    _bloc.add(GetLanguageEvent());
    _bloc.add(GatLandingDataEvent(request: OffersRequest(pageCode: "appHome")));
    _getCurrentCountryCode();
  }

  void _getCurrentCountryCode() async {
    final countryIpResponse = await CountryIp.find();
    await SaveCurrentCountryCodeUseCase(injector())(
        countryIpResponse?.countryCode ?? "EG");
  }

  @override
  void dispose() async {
    await SetNoInternetUseCase(injector())(false);
    super.dispose();
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<LandingBloc, LandingState>(
      listener: (context, state) {
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetOffersDataSuccessState) {
        } else if (state is GetOffersDataFailedState) {
          showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              _navigateBackEvent();
            },
          );
        }
        if (state is GetLandingDataSuccessState) {
          features = state.landingData.features;
          partners = state.landingData.partners;
          socialMedias.clear();
          for (var element in state.landingData.socialMedia) {
            if (element.extraValueOne != '') {
              socialMedias.add(element);
            }
          }
        } else if (state is GetLandingDataErrorState) {
          showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              _navigateBackEvent();
            },
          );
        }
        if (state is GetLanguagesSuccessState) {
          _languages = state.languages;
          _openLanguageBottomSheetEvent(languages: _languages);
        } else if (state is GetLanguagesErrorState) {
          showMassageDialogWidget(
            context: context,
            text: state.message,
            icon: ImagePaths.error,
            buttonText: S.of(context).ok,
            onTap: () {
              _navigateBackEvent();
            },
          );
        } else if (state is OpenLanguageBottomSheetState) {
          showLanguageBottomSheet(
            context: context,
            height: 400,
            languages: state.languages,
            selectedLanguage: selectedLanguage,
            onLanguageSelected: (language) {
              _navigateBackEvent();
              if (language.code == selectedLanguage.code) return;
              selectedLanguage = language;
              _bloc.add(
                SetLanguageEvent(
                  languageCode: selectedLanguage.code,
                ),
              );
              _navigateBackEvent();
            },
          );
        } else if (state is NavigateToSignInScreenState) {
          Navigator.pushNamed(context, Routes.signIn, arguments: {
            "unitId": state.firebaseNotificationData != null
                ? state.firebaseNotificationData!.unitId
                : -1,
          });
        } else if (state is NavigateToSignUpScreenState) {
          Navigator.pushNamed(context, Routes.register);
        } else if (state is NavigateToContactUsScreenState) {
          Navigator.pushNamed(context, Routes.contactUs);
        } else if (state is OpenFeatureScreenState) {
        } else if (state is GetLanguageState) {
          selectedLanguage = selectedLanguage.copyWith(
            code: state.languageCode,
          );
        } else if (state is SetLanguageState) {
          RestartWidget.restartApp(context);
        } else if (state is OpenSocialMediaState) {
          _openSocialMedia(state.socialMedia);
        } else if (state is NavigateBackState) {
          Navigator.of(context).pop();
        } else if (state is GetLandingsDataSuccessState) {
          _languages = state.languages;
          _offers = state.offers;
          features = state.landingData.features;
          partners = state.landingData.partners;
          socialMedias.clear();
          for (var element in state.landingData.socialMedia) {
            if (element.extraValueOne != '') {
              socialMedias.add(element);
            }
          }
        } else if (state is OnTapOfferNavigateToWebViewState) {
          Navigator.pushNamed(context, Routes.webContent, arguments: {
            "screenTitle": state.offer.title,
            "content": state.offer.redirectUrl,
            "isLink": true,
          });
        }
      },
      builder: (context, state) {
        if (state is ShowSkeletonState) return const SkeletonLandingScreen();
        return _buildLandingScreen();
      },
    );
  }

  Scaffold _buildLandingScreen() {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: F.cityEye,
        imagePath: ImagePaths.logo,
        isHaveBackButton: false,
        backgroundColor: ColorSchemes.primary.withOpacity(0.04),
        actionWidget: InkWell(
          onTap: () {
            _bloc.add(GetLanguagesEvent());
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  ImagePaths.globe,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  selectedLanguage.code.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.13,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: socialMedias.isNotEmpty
          ? ExpandableFabWidget(
              children: socialMedias
                  .map(
                    (socialMedia) => _buildSocialMediaWidget(
                      socialMedia,
                      () {
                        _openSocialMediaEvent(socialMedia);
                      },
                    ),
                  )
                  .toList(),
            )
          : null,
      body: WillPopScope(
        onWillPop: () {
          _onWillPop();
          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(
                signIn: () {
                  _navigateToSignInScreenEvent();
                },
                signUp: () {
                  _navigateToSignUpScreenEvent();
                },
              ),
              Visibility(
                visible: _offers.isNotEmpty,
                child: const SizedBox(height: 24),
              ),
              Visibility(
                visible: _offers.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SliderWidget(
                    height: 160,
                    offers: _offers,
                    onTap: (offer) {
                      _onTapOfferEvent(offer: offer);
                    },
                  ),
                ),
              ),
              Visibility(
                visible: _offers.isNotEmpty,
                child: const  SizedBox(height: 24),
              ),
              partners.isNotEmpty
                  ? PartnersSection(
                      partners: partners,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 24),
              features.isNotEmpty
                  ? FeaturesSection(
                      cards: features,
                      onFeatureTap: (Feature feature) {
                        _openFeatureScreenEvent(feature);
                      },
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 32),
              ContactUsSection(
                onRequestNow: () {
                  _navigateToContactUsScreenEvent();
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaWidget(SocialMedia socialMedia, Function() onTap) {
    return socialMedia.extraValueOne.isEmpty
        ? const SizedBox.shrink()
        : InkWell(
            onTap: onTap,
            child: CircularIcon(
              iconSize: 24,
              backgroundColor: ColorSchemes.iconBackGround,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color.fromRGBO(34, 34, 34, 0.32),
                  spreadRadius: 0,
                ),
              ],
              isNetworkImage: true,
              imagePath:
                  socialMedia.logo != "" ? socialMedia.logo : ImagePaths.frame,
              iconColor: ColorSchemes.primary,
            ),
          );
  }

  void _openLanguageBottomSheetEvent({
    required List<Language> languages,
  }) {
    _bloc.add(OpenLanguageBottomSheetEvent(
      languages: languages,
    ));
  }

  void _navigateToSignInScreenEvent(
      {FirebaseNotificationData? firebaseNotificationData}) {
    _bloc.add(NavigateToSignInScreenEvent(
        firebaseNotificationData: firebaseNotificationData));
  }

  void _navigateToSignUpScreenEvent() {
    _bloc.add(NavigateToSignUpScreenEvent());
  }

  void _openFeatureScreenEvent(Feature feature) {
    _bloc.add(OpenFeatureScreenEvent(feature: feature));
  }

  void _navigateToContactUsScreenEvent() {
    _bloc.add(NavigateToContactUsScreenEvent());
  }

  void _openSocialMediaEvent(SocialMedia socialMedia) {
    _bloc.add(OpenSocialMediaEvent(socialMedia: socialMedia));
  }

  void _navigateBackEvent() {
    _bloc.add(NavigateBackEvent());
  }

  Future<void> _openSocialMedia(SocialMedia socialMedia) async {
    if (!await launchUrl(Uri.parse(socialMedia.extraValueOne))) {
      //TODO show error
      throw Exception('Could not launch ${socialMedia.extraValueOne}');
    }
  }

  void _onWillPop() {
    showActionDialogWidget(
        context: context,
        text: S.of(context).areYouSureYouWantExitCityEye,
        icon: ImagePaths.warning,
        primaryText: S.of(context).no,
        secondaryText: S.of(context).yes,
        primaryAction: () {
          Navigator.pop(context);
        },
        secondaryAction: () {
          exit(0);
        });
  }

  void _notificationListener() {
    NotificationService.onNotificationClick.stream.listen((event) {
      _onNotificationClick(event);
    });
  }

  void _onNotificationClick(String? notificationData) async {
    FirebaseNotificationData firebaseNotificationData =
        mapNotification(notificationData);

    _navigateToSignInScreenEvent(
        firebaseNotificationData: firebaseNotificationData);
  }

  FirebaseNotificationData mapNotification(String? notificationData) {
    Map<String, dynamic> mapDate = json.decode(notificationData!);
    FirebaseNotificationData model = FirebaseNotificationData.fromJson(mapDate);

    return model;
  }

  void _onTapOfferEvent({required Offer offer}) {
    _bloc.add(OnTapOfferEvent(offer: offer));
  }
}
