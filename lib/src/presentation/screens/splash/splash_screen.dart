import 'package:city_eye/flavors.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/core/utils/show_snack_bar.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/domain/usecase/get_switch_logo_use_case.dart';
import 'package:city_eye/src/domain/usecase/get_user_unit_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_qr_code_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_support_index_use_case.dart';
import 'package:city_eye/src/domain/usecase/set_switch_logo_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _isRememberMe = false;
  bool _isRestartApp = false;
  bool _hasInitialized = false;
  String _switchLogo = "";

  bool _initialUriIsHandled = false;
  StreamSubscription? _sub;

  @override
  void initState() {
    _switchLogo = GetSwitchLogoUseCase(injector())();

    super.initState();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
      }, onError: (Object err) {
        if (!mounted) return;
      });
    }
    _handleInitialUri();
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          if (!_isRestartApp) {
            handleLinkData(uri);
          }
        } else {
          return;
        }
        if (!mounted) return;
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
      } on FormatException catch (err) {
        if (!mounted) return;
      }
    }
  }

  void handleLinkData(Uri uri) {
    final Uri deepLink = uri;

    if (deepLink.queryParameters.containsKey('invitedUserExistsStatus') &&
        deepLink.queryParameters['invitedUserExistsStatus'] == "False") {
      Navigator.pushReplacementNamed(
        context,
        Routes.resetPasswordScreen,
        arguments: {
          "phoneNumber": deepLink.queryParameters['mobileNumber'] ?? "0",
          "userId":
              int.parse(deepLink.queryParameters['familyMemberId'] ?? "0"),
          "invitationId": int.parse(deepLink.queryParameters['id'] ?? "0"),
          "isFromDeepLink": true,
        },
      );
    } else if (deepLink.queryParameters
            .containsKey('invitedUserExistsStatus') &&
        deepLink.queryParameters['invitedUserExistsStatus'] == "True") {
      if (deepLink.queryParameters.containsKey('isOtpVerified') &&
          deepLink.queryParameters['isOtpVerified'] == "True") {
        Navigator.pushReplacementNamed(
          context,
          Routes.signIn,
          arguments: {
            "unitId": -1,
            "isFromDeepLink": true,
          },
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          Routes.otp,
          arguments: {
            "phoneNumber": deepLink.queryParameters['mobileNumber'] ?? "0",
            "userId":
                int.parse(deepLink.queryParameters['familyMemberId'] ?? "0"),
            "invitationId": int.parse(deepLink.queryParameters['id'] ?? "0"),
            "isFromDeepLink": true,
          },
        );
      }
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    await SetSupportIndexUseCase(injector())(["0", "0", ""]);
    await SetQrCodeIndexUseCase(injector())(["0", "0", "0"]);

    _isRememberMe = (await SharedPreferences.getInstance())
            .getBool(SharedPreferenceKeys.rememberMe) ??
        false;
    _isRestartApp = (await SharedPreferences.getInstance())
            .getBool(SharedPreferenceKeys.isRestart) ??
        false;

    _handleIncomingLinks();

    if (!_hasInitialized) {
      _hasInitialized = true;
      if (_isRestartApp) {
        (await SharedPreferences.getInstance())
            .setBool(SharedPreferenceKeys.isRestart, false);
        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.main, (route) => false,
              arguments: {
                "selectIndex": 0,
              });
        }
      } else {
        if (_isRememberMe) {
          await Future.delayed(const Duration(seconds: 3));
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.main, (route) => false,
                arguments: {
                  "selectIndex": 0,
                });
          }
        } else {
          (await SharedPreferences.getInstance())
              .remove(SharedPreferenceKeys.user);
          (await SharedPreferences.getInstance())
              .remove(SharedPreferenceKeys.userUnit);
          await Future.delayed(const Duration(seconds: 3));
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.landing,
              (route) => false,
            );
          }
        }
      }
      if (GetSwitchLogoUseCase(injector())() != "") {
        showSnackBar(
          context: context,
          message:
          "${S.current.youHaveBeenSwitchedTo} ${GetUserUnitUseCase(injector())().unitName}",
          color: ColorSchemes.snackBarInfo,
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ColorSchemes.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: _switchLogo.isEmpty
              ? Stack(fit: StackFit.expand, children: [
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        width: 220,
                        height: 220,
                        ImagePaths.splashLogo,
                      ),
                      Container(
                        color: ColorSchemes.iconBackGround,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Text(
                            S.of(context).stayConnectedStaySmarter,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorSchemes.black,
                                      fontWeight: Constants.fontWeightMedium,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 102,
                      ),
                    ],
                  )),
                  Positioned(
                      bottom: 150,
                      right: 0,
                      left: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${S.of(context).poweredBy}  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ColorSchemes.gray,
                                    letterSpacing: -0.24,
                                  ),
                            ),
                            Text(
                              F.cityEye,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                            )
                          ])),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      width: MediaQuery.sizeOf(context).width,
                      ImagePaths.splashBackground,
                    ),
                  ),
                ])
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            width: 232,
                            height: 232,
                            ImagePaths.switchSplash,
                            fit: BoxFit.cover,
                            color: ColorSchemes.primary,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorSchemes.greyDivider,
                                // color of the border
                                width: 2, // width of the border
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                height: 130,
                                width: 130,
                                _switchLogo,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  height: 130,
                                  width: 130,
                                  ImagePaths.imagePlaceHolder,
                                  fit: BoxFit.cover,
                                ),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: ColorSchemes.primary,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        GetUserUnitUseCase(injector())().compoundName,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorSchemes.primary,
                              fontSize: 20,
                              letterSpacing: -0.24,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        GetUserUnitUseCase(injector())().unitName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorSchemes.primary,
                          fontSize: 20,
                          letterSpacing: -0.24,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Image.asset(
                        width: 120,
                        height: 120,
                        ImagePaths.splashLogo,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    await SetSwitchLogoUseCase(injector())("");
    _sub?.cancel();
    super.dispose();
  }
}
