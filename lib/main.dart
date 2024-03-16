import 'dart:io';
import 'dart:ui';

import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/config/theme/app_theme.dart';
import 'package:city_eye/src/core/utils/bloc_observer.dart';
import 'package:city_eye/src/core/utils/network_connectivity.dart';
import 'package:city_eye/src/core/utils/notification_services.dart';
import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/presentation/blocs/add_car/add_car_bloc.dart';
import 'package:city_eye/src/presentation/blocs/add_family_member/add_family_bloc.dart';
import 'package:city_eye/src/presentation/blocs/add_unit/add_unit_bloc.dart';
import 'package:city_eye/src/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/community_request/community_request_bloc.dart';
import 'package:city_eye/src/presentation/blocs/comment/comments_bloc.dart';
import 'package:city_eye/src/presentation/blocs/complain/complain_bloc.dart';
import 'package:city_eye/src/presentation/blocs/delegated/delegated_bloc.dart';
import 'package:city_eye/src/presentation/blocs/compound/compound_bloc.dart';
import 'package:city_eye/src/presentation/blocs/contact_us/contact_us_bloc.dart';
import 'package:city_eye/src/presentation/blocs/dynamic_questions/dynamic_questions_bloc.dart';
import 'package:city_eye/src/presentation/blocs/gallery/gallery_bloc.dart';
import 'package:city_eye/src/presentation/blocs/history/history_bloc.dart';
import 'package:city_eye/src/presentation/blocs/my_cart/my_cart_bloc.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:city_eye/src/presentation/blocs/orders/orders_bloc.dart';
import 'package:city_eye/src/presentation/blocs/otp/otp_bloc.dart';
import 'package:city_eye/src/presentation/blocs/payment/payment_bloc.dart';
import 'package:city_eye/src/presentation/blocs/payment_details/payment_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/profile/profile_bloc.dart';
import 'package:city_eye/src/presentation/blocs/qr_configuration/qr_configuration_bloc.dart';
import 'package:city_eye/src/presentation/blocs/qr_details/qr_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/services/my_subscriptions/my_subscriptions_bloc.dart';
import 'package:city_eye/src/presentation/blocs/service_details_cart/service_details_cart_bloc.dart';
import 'package:city_eye/src/presentation/blocs/register/register_bloc.dart';
import 'package:city_eye/src/presentation/blocs/settings/settings_bloc.dart';
import 'package:city_eye/src/presentation/blocs/event/details/event_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/events/events_bloc.dart';
import 'package:city_eye/src/presentation/blocs/forget_password/forget_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/home/home_bloc.dart';
import 'package:city_eye/src/presentation/blocs/landing/landing_bloc.dart';
import 'package:city_eye/src/presentation/blocs/main/main_bloc.dart';
import 'package:city_eye/src/presentation/blocs/more/more_bloc.dart';
import 'package:city_eye/src/presentation/blocs/service_details/service_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/services/my_services_bloc.dart';
import 'package:city_eye/src/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:city_eye/src/presentation/blocs/support/support_bloc.dart';
import 'package:city_eye/src/presentation/blocs/support_details/support_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_bloc.dart';
import 'package:city_eye/src/presentation/blocs/units/units_bloc.dart';
import 'package:city_eye/src/presentation/blocs/wall/wall_bloc.dart';
import 'package:city_eye/src/presentation/screens/pdf_viewer/pdf_screen.dart';
import 'package:city_eye/src/presentation/widgets/restart_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'firebase_options.dart';
import 'src/presentation/blocs/badge_identity/badge_identity_bloc.dart';
import 'src/presentation/blocs/delegated_steps/delegated_steps_bloc.dart';
import 'src/presentation/blocs/notifications/notification_details/notification_details_bloc.dart';
import 'src/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'src/presentation/blocs/staff/staff_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  if (Platform.isIOS) {
    await _initializeFirebaseServices();
  } else {
    final int resultCode =
        await HmsApiAvailability().isHMSAvailableWithApkVersion(28);
    if (resultCode == 1) {
      await _initializeFirebaseServices();
    } else {
      await _initializeHuaweiServices();
    }
  }

  runApp(const RestartWidget(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isOnline = true;

  @override
  void initState() {
    _internetConnectionListener();
    super.initState();
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(create: (context) => injector()),
          BlocProvider<LandingBloc>(create: (context) => injector()),
          BlocProvider<SignInBloc>(create: (context) => injector()),
          BlocProvider<ForgetPasswordBloc>(create: (context) => injector()),
          BlocProvider<MoreBloc>(create: (context) => injector()),
          BlocProvider<StaffBloc>(create: (context) => injector()),
          BlocProvider<WallBloc>(create: (context) => injector()),
          BlocProvider<MyServicesBloc>(create: (context) => injector()),
          BlocProvider<ServiceDetailsBloc>(create: (context) => injector()),
          BlocProvider<SupportBloc>(create: (context) => injector()),
          BlocProvider<EventDetailsBloc>(create: (context) => injector()),
          BlocProvider<HomeBloc>(create: (context) => injector()),
          BlocProvider<SurveyBloc>(create: (context) => injector()),
          BlocProvider<EventsBloc>(create: (context) => injector()),
          BlocProvider<SettingsBloc>(create: (context) => injector()),
          BlocProvider<ChangePasswordBloc>(create: (context) => injector()),
          BlocProvider<GalleryBloc>(create: (context) => injector()),
          BlocProvider<OtpBloc>(create: (context) => injector()),
          BlocProvider<DelegatedBloc>(create: (context) => injector()),
          BlocProvider<MySubscriptionsBloc>(create: (context) => injector()),
          BlocProvider<SupportDetailsBloc>(create: (context) => injector()),
          BlocProvider<ServiceDetailsCartBloc>(create: (context) => injector()),
          BlocProvider<RegisterBloc>(create: (context) => injector()),
          BlocProvider<CompoundBloc>(create: (context) => injector()),
          BlocProvider<UnitsBloc>(create: (context) => injector()),
          BlocProvider<QrDetailsBloc>(create: (context) => injector()),
          BlocProvider<NotificationsBloc>(create: (context) => injector()),
          BlocProvider<NotificationDetailsBloc>(
              create: (context) => injector()),
          BlocProvider<ContactUsBloc>(create: (context) => injector()),
          BlocProvider<PaymentBloc>(create: (context) => injector()),
          BlocProvider<DelegatedStepsBloc>(create: (context) => injector()),
          BlocProvider<ProfileBloc>(create: (context) => injector()),
          BlocProvider<AddFamilyBloc>(create: (context) => injector()),
          BlocProvider<AddCarBloc>(create: (context) => injector()),
          BlocProvider<HistoryBloc>(create: (context) => injector()),
          BlocProvider<ComplainBloc>(create: (context) => injector()),
          BlocProvider<CommunityRequestBloc>(create: (context) => injector()),
          BlocProvider<OrdersBloc>(create: (context) => injector()),
          BlocProvider<CommentsBloc>(create: (context) => injector()),
          BlocProvider<DynamicQuestionsBloc>(create: (context) => injector()),
          BlocProvider<AddUnitBloc>(create: (context) => injector()),
          BlocProvider<QrConfigurationBloc>(create: (context) => injector()),
          BlocProvider<ResetPasswordBloc>(create: (context) => injector()),
          BlocProvider<PaymentDetailsBloc>(create: (context) => injector()),
          BlocProvider<BadgeIdentityBloc>(create: (context) => injector()),
          BlocProvider<MyCartBloc>(create: (context) => injector()),
        ],
        child: BlocBuilder<MainCubit, Locale>(
          buildWhen: (previousState, currentState) {
            return previousState != currentState;
          },
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              themeMode: ThemeMode.light,
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: RoutesManager.getRoute,
              initialRoute: Routes.splash,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: F.title,
              theme: AppTheme(state.languageCode).light,
              locale: state,
            );
          },
        ));
  }

  void _internetConnectionListener() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) async {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.wifi:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.none:
        default:
          isOnline = false;
      }
      _networkConnectivity.showOrHideNoInternetDialog(isOnline, navigatorKey.currentState!.context);
    });
  }

}

Future<void> _initializeFirebaseServices() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NotificationService().initializeNotificationService();
    Bloc.observer = const SimpleBlocObserver();
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } catch(e) {

  }

}

Future<void> _initializeHuaweiServices() async {}
