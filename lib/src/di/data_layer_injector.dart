import 'package:city_eye/flavors.dart';
import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/badge_identity/badge_identity_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/community_request_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/complain_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/delegated_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/events_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/landing/landing_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/home_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/contact_us_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/notification/notification_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/payment_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/profile/profile_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/qr_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/reset_password/reset_password_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/service_details_cart_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/settings_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/login_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/register/register_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/support_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/survey_api_services.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/wall_api_service.dart';
import 'package:city_eye/src/presentation/screens/otp/utils/timer_ticker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> initializeDataDependencies() async {
  injector.registerLazySingleton(() => Dio()
    ..options.baseUrl = F.baseUrl
    ..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    )));

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  injector.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  injector.registerSingleton<LoginAPIService>(LoginAPIService(injector()));

  injector
      .registerSingleton<SettingsAPIService>(SettingsAPIService(injector()));

  injector
      .registerSingleton<RegisterAPIService>(RegisterAPIService(injector()));

  injector.registerSingleton<ProfileAPIService>(ProfileAPIService(injector()));

  injector.registerSingleton<ServiceDetailsCartApiService>(
      ServiceDetailsCartApiService(injector()));

  injector
      .registerSingleton<ContactUsAPIService>(ContactUsAPIService(injector()));

  injector.registerSingleton<PaymentAPIService>(PaymentAPIService(injector()));

  injector.registerSingleton<WallAPIService>(WallAPIService(injector()));

  injector.registerSingleton<GetHomeCompoundAPIService>(
      GetHomeCompoundAPIService(injector()));

  injector.registerSingleton<LandingAPIService>(LandingAPIService(injector()));

  injector.registerSingleton<EventsAPIServices>(EventsAPIServices(injector()));

  injector.registerSingleton<SurveyAPIServices>(SurveyAPIServices(injector()));

  injector.registerSingleton<SupportAPIService>(SupportAPIService(injector()));

  injector.registerSingleton<QrAPIService>(QrAPIService(injector()));

  injector
      .registerSingleton<DelegatedAPIService>(DelegatedAPIService(injector()));

  injector.registerSingleton<NotificationApiService>(
      NotificationApiService(injector()));

  injector.registerSingleton<CommunityRequestAPIService>(
      CommunityRequestAPIService(injector()));
  injector
      .registerSingleton<ComplainAPIService>(ComplainAPIService(injector()));
  injector.registerFactory<TimerTicker>(() => const TimerTicker());

  injector.registerSingleton<ResetPasswordService>(
      ResetPasswordService(injector()));

  injector.registerSingleton<BadgeIdentityApiServices>(
      BadgeIdentityApiServices(injector()));
}
