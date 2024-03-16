import 'package:city_eye/src/di/injector.dart';
import 'package:city_eye/src/presentation/blocs/add_car/add_car_bloc.dart';
import 'package:city_eye/src/presentation/blocs/add_family_member/add_family_bloc.dart';
import 'package:city_eye/src/presentation/blocs/add_unit/add_unit_bloc.dart';
import 'package:city_eye/src/presentation/blocs/badge_identity/badge_identity_bloc.dart';
import 'package:city_eye/src/presentation/blocs/community_request/community_request_bloc.dart';
import 'package:city_eye/src/presentation/blocs/comment/comments_bloc.dart';
import 'package:city_eye/src/presentation/blocs/complain/complain_bloc.dart';
import 'package:city_eye/src/presentation/blocs/delegated/delegated_bloc.dart';
import 'package:city_eye/src/presentation/blocs/compound/compound_bloc.dart';
import 'package:city_eye/src/presentation/blocs/delegated_steps/delegated_steps_bloc.dart';
import 'package:city_eye/src/presentation/blocs/dynamic_questions/dynamic_questions_bloc.dart';
import 'package:city_eye/src/presentation/blocs/history/history_bloc.dart';
import 'package:city_eye/src/presentation/blocs/my_cart/my_cart_bloc.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notification_details/notification_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/notifications/notifications_bloc.dart';
import 'package:city_eye/src/presentation/blocs/contact_us/contact_us_bloc.dart';
import 'package:city_eye/src/presentation/blocs/orders/orders_bloc.dart';
import 'package:city_eye/src/presentation/blocs/otp/otp_bloc.dart';
import 'package:city_eye/src/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/payment/payment_bloc.dart';
import 'package:city_eye/src/presentation/blocs/payment_details/payment_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/profile/profile_bloc.dart';
import 'package:city_eye/src/presentation/blocs/qr_configuration/qr_configuration_bloc.dart';
import 'package:city_eye/src/presentation/blocs/qr_details/qr_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/reset_password/reset_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/services/my_subscriptions/my_subscriptions_bloc.dart';
import 'package:city_eye/src/presentation/blocs/service_details_cart/service_details_cart_bloc.dart';
import 'package:city_eye/src/presentation/blocs/register/register_bloc.dart';
import 'package:city_eye/src/presentation/blocs/settings/settings_bloc.dart';
import 'package:city_eye/src/presentation/blocs/events/events_bloc.dart';
import 'package:city_eye/src/presentation/blocs/gallery/gallery_bloc.dart';
import 'package:city_eye/src/presentation/blocs/home/home_bloc.dart';
import 'package:city_eye/src/presentation/blocs/staff/staff_bloc.dart';
import 'package:city_eye/src/presentation/blocs/support_details/support_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/survey/survey_bloc.dart';
import 'package:city_eye/src/presentation/blocs/event/details/event_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/support/support_bloc.dart';
import 'package:city_eye/src/presentation/blocs/service_details/service_details_bloc.dart';
import 'package:city_eye/src/presentation/blocs/services/my_services_bloc.dart';
import 'package:city_eye/src/presentation/blocs/units/units_bloc.dart';
import 'package:city_eye/src/presentation/blocs/wall/wall_bloc.dart';
import 'package:city_eye/src/presentation/blocs/more/more_bloc.dart';
import 'package:city_eye/src/presentation/blocs/forget_password/forget_password_bloc.dart';
import 'package:city_eye/src/presentation/blocs/landing/landing_bloc.dart';
import 'package:city_eye/src/presentation/blocs/main/main_bloc.dart';
import 'package:city_eye/src/presentation/blocs/sign_in/sign_in_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<MainCubit>(() => MainCubit(
        injector(),
        injector(),
      ));

  injector.registerFactory<LandingBloc>(() => LandingBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<SignInBloc>(() => SignInBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<ForgetPasswordBloc>(() => ForgetPasswordBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<HomeBloc>(() => HomeBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<SurveyBloc>(() => SurveyBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<MoreBloc>(() => MoreBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<StaffBloc>(
    () => StaffBloc(
      injector(),
    ),
  );

  injector.registerFactory<WallBloc>(
    () => WallBloc(
      injector(),
    ),
  );

  injector.registerFactory<MyServicesBloc>(() => MyServicesBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<ServiceDetailsBloc>(() => ServiceDetailsBloc());

  injector.registerFactory<SupportBloc>(() => SupportBloc(injector()));
  injector.registerFactory<EventDetailsBloc>(() => EventDetailsBloc(
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<OtpBloc>(
    () => OtpBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<GalleryBloc>(() => GalleryBloc(injector()));
  injector.registerFactory<EventsBloc>(() => EventsBloc(
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<SettingsBloc>(
    () => SettingsBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
    ),
  );

  injector.registerFactory<ChangePasswordBloc>(() => ChangePasswordBloc(
        injector(),
        injector(),
      ));
  injector.registerFactory<DelegatedBloc>(() => DelegatedBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<MySubscriptionsBloc>(() => MySubscriptionsBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<SupportDetailsBloc>(() => SupportDetailsBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<ServiceDetailsCartBloc>(() => ServiceDetailsCartBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<RegisterBloc>(() => RegisterBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<CompoundBloc>(
    () => CompoundBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
    ),
  );

  injector.registerFactory<UnitsBloc>(
    () => UnitsBloc(
      injector(),
    ),
  );

  injector.registerFactory<QrDetailsBloc>(() => QrDetailsBloc(
        injector(),
      ));

  injector.registerFactory<NotificationsBloc>(() => NotificationsBloc(
        injector(),
        injector(),
      ));

  injector
      .registerFactory<NotificationDetailsBloc>(() => NotificationDetailsBloc(
            injector(),
          ));

  injector.registerFactory<ProfileBloc>(() => ProfileBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<AddFamilyBloc>(() => AddFamilyBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<AddCarBloc>(() => AddCarBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<ContactUsBloc>(() => ContactUsBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<PaymentBloc>(() => PaymentBloc(
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<HistoryBloc>(() => HistoryBloc(
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<ComplainBloc>(() => ComplainBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<DelegatedStepsBloc>(() => DelegatedStepsBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<CommunityRequestBloc>(() => CommunityRequestBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<OrdersBloc>(() => OrdersBloc(
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<CommentsBloc>(() => CommentsBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<DynamicQuestionsBloc>(() => DynamicQuestionsBloc(
        injector(),
      ));

  injector.registerFactory<AddUnitBloc>(() => AddUnitBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<QrConfigurationBloc>(() => QrConfigurationBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(
        injector(),
      ));

  injector.registerFactory<PaymentDetailsBloc>(() => PaymentDetailsBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<BadgeIdentityBloc>(() => BadgeIdentityBloc(
        injector(),
        injector(),
      ));

  injector.registerFactory<MyCartBloc>(() => MyCartBloc(
        injector(),
        injector(),
      ));
}