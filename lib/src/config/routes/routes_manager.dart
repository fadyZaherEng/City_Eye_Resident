import 'dart:io';

import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/home/home_service.dart';
import 'package:city_eye/src/domain/entities/home/home_support.dart';
import 'package:city_eye/src/domain/entities/notification/notification_item.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/entities/wall/images_screen.dart';
import 'package:city_eye/src/presentation/screens/add_unit/add_unit_screen.dart';
import 'package:city_eye/src/presentation/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:city_eye/src/presentation/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:city_eye/src/presentation/screens/badge_identity/badge_identity_screen.dart';
import 'package:city_eye/src/presentation/screens/main/screen/main_screen.dart';
import 'package:city_eye/src/presentation/screens/change_password/change_password_screen.dart';
import 'package:city_eye/src/presentation/screens/comment/comments_screen.dart';
import 'package:city_eye/src/presentation/screens/community_request/community_request_screen.dart';
import 'package:city_eye/src/presentation/screens/complain/complain_screen.dart';
import 'package:city_eye/src/presentation/screens/contact_us/contact_us_screen.dart';
import 'package:city_eye/src/presentation/screens/delegated/delegated_screen.dart';
import 'package:city_eye/src/presentation/screens/delegated_steps/delegated_steps_screen.dart';
import 'package:city_eye/src/presentation/screens/events/details/event_details_screen.dart';
import 'package:city_eye/src/presentation/screens/events/events_screen.dart';
import 'package:city_eye/src/presentation/screens/gallery_screen/gallery_screen.dart';
import 'package:city_eye/src/presentation/screens/gallery_screen/widgets/gallery_images_screen.dart';
import 'package:city_eye/src/presentation/screens/landing/landing_screen.dart';
import 'package:city_eye/src/presentation/screens/more/more_screen.dart';
import 'package:city_eye/src/presentation/screens/my_cart/my_cart_screen.dart';
import 'package:city_eye/src/presentation/screens/no_internet/no_internet_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_details_screen/notifications_details_screen.dart';
import 'package:city_eye/src/presentation/screens/notifications/notifications_screen/notifications_screen.dart';
import 'package:city_eye/src/presentation/screens/otp/otp_screen.dart';
import 'package:city_eye/src/presentation/screens/payment/payment_screen.dart';
import 'package:city_eye/src/presentation/screens/payment_details/payment_details_screen.dart';
import 'package:city_eye/src/presentation/screens/pdf_viewer/pdf_screen.dart';
import 'package:city_eye/src/presentation/screens/play_video_screen/play_video_screen.dart';
import 'package:city_eye/src/presentation/screens/profile/profile_screen.dart';
import 'package:city_eye/src/presentation/screens/qr/qr_screen.dart';
import 'package:city_eye/src/presentation/screens/qr_details_screen/qr_details_screen.dart';
import 'package:city_eye/src/presentation/screens/register/register_screen.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/select_compound/select_compound_screen.dart';
import 'package:city_eye/src/presentation/screens/reset_password/ResetPasswordScreen.dart';
import 'package:city_eye/src/presentation/screens/service_details/service_details_screen.dart';
import 'package:city_eye/src/presentation/screens/service_details_cart/service_details_cart_screen.dart';
import 'package:city_eye/src/presentation/screens/settings/settings_screen.dart';
import 'package:city_eye/src/presentation/screens/splash/splash_screen.dart';
import 'package:city_eye/src/presentation/screens/staff/staff_screen.dart';
import 'package:city_eye/src/presentation/screens/support_details/support_details_screen.dart';
import 'package:city_eye/src/presentation/screens/survey/survey_screen.dart';
import 'package:city_eye/src/presentation/screens/wall/widget/wall_images_screen.dart';
import 'package:city_eye/src/presentation/screens/web_view/web_view_screen.dart';
import 'package:city_eye/src/presentation/widgets/video_trimmer_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Routes {
  static const String deepLinking = "https://connecteye.com";
  static const String otp = "/otp";
  static const String splash = "/";
  static const String landing = "/landing";
  static const String signIn = "signIn";
  static const String forgetPassword = "/forgetPassword";
  static const String main = "/main";
  static const String stuff = "/stuff";
  static const String webContent = "/webContent";
  static const String wallImages = "/wallImages";
  static const String serviceDetails = "/serviceDetails";
  static const String events = "/events";
  static const String eventDetails = "/eventDetails";
  static const String surveys = "/surveys";
  static const String gallery = "/gallery";
  static const String galleryImages = "/galleryImages";
  static const String settings = "/settings";
  static const String changePassword = "/changePassword";
  static const String delegated = "/delegated";

  // static const String servicesScreen = "/servicesScreen";
  static const String noInternet = "/noInternet";
  static const String supportDetails = "/supportDetails";
  static const String videoTrimmer = "/videoTrimmer";
  static const String serviceDetailsCart = "/serviceDetailsCart";
  static const String register = "/register";
  static const String compound = "/compound";
  static const String qrDetailsScreen = "/qrDetailsScreen";
  static const String notifications = "/notificationsScreen";
  static const String notificationsDetailsScreen =
      "/notificationsDetailsScreen";
  static const String contactUs = "/contactUs";
  static const String qr = "/qr";
  static const String complain = "/complain";
  static const String payment = "/paymet";
  static const String delegatedStepsScreen = "/delegatedStepsScreen";
  static const String moreScreen = "/moreScreen";
  static const String profile = "/profileScreen";
  static const String communityRequest = "/communityRequest";
  static const String commentScreen = "/comment";
  static const String addUnit = "/addUnit";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String paymentDetails = "/paymentDetails";
  static const String badgeIdentity = "/badgeIdentity";
  static const String playVideoScreen = "/playVideoScreen";
  static const String pdfScreen = "/pdfScreen";
  static const String myCart = "/myCart";
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case Routes.splash:
      // case Routes.deepLinking:
      //   return _materialRoute(const SplashScreen());
      case Routes.landing:
        return _materialRoute(const LandingScreen());
      case Routes.signIn:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(SignInScreen(
          unitId: arg["unitId"] ?? -1,
          isFromDeepLink: arg["isFromDeepLink"] ?? false,
        ));
      case Routes.forgetPassword:
        return _materialRoute(const ForgetPasswordScreen());
      case Routes.main:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(MainScreen(
          selectIndex: arg["selectIndex"] ?? 0,
        ));
      case Routes.stuff:
        return _materialRoute(const StaffScreen());
      case Routes.webContent:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          WebViewScreen(
            screenTitle: arg['screenTitle'] ?? "",
            content: arg['content'] ?? "",
            isLink: arg["isLink"] ?? false,
            isPdf: arg["isPdf"] ?? false,
          ),
        );
      case Routes.wallImages:
        ImagesScreen imagesScreen = routeSettings.arguments as ImagesScreen;
        return _materialRoute(WallImagesScreen(
          imagesScreen: imagesScreen,
        ));
      case Routes.serviceDetails:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(ServiceDetailsScreen(
          homeServices: arg['homeServices'] as List<HomeService>,
          homeService: arg['homeService'] as HomeService,
          isFromHome: arg["isFromHome"] ?? false,
        ));
      case Routes.events:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(EventsScreen(
          id: arg["id"] ?? -1,
        ));
      case Routes.eventDetails:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(EventDetailsScreen(
          eventId: arg["eventId"] as int,
        ));
      case Routes.surveys:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(SurveyScreen(
          id: arg["id"] ?? -1,
        ));
      case Routes.otp:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(OTPScreen(
          phoneNumber: arg["phoneNumber"] as String,
          userId: arg["userId"] as int,
          invitationId: arg["invitationId"] ?? 0,
          otp: arg["otp"] ?? "",
          compoundID: arg["compoundID"] ?? 0,
          isFromDeepLink: arg["isFromDeepLink"] ?? false,
        ));
      case Routes.gallery:
        return _materialRoute(const GalleryScreen());
      case Routes.galleryImages:
        GalleryImages imagesScreen = routeSettings.arguments as GalleryImages;
        return _materialRoute(GalleryImagesScreen(
          imagesScreen: imagesScreen,
        ));
      case Routes.settings:
        return _materialRoute(
          const SettingsScreen(),
        );
      case Routes.changePassword:
        return _materialRoute(
          const ChangePasswordScreen(),
        );
      case Routes.delegated:
        return _materialRoute(
          const DelegatedScreen(),
        );
      case Routes.noInternet:
        return _materialRoute(NoInternetScreen(
            tryAgainAction: routeSettings.arguments as Function()));
      case Routes.supportDetails:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          SupportDetailsScreen(
            supportServices: arg["supportServices"] as List<HomeSupport>,
            selectedSupportService:
                arg["selectedSupportService"] as HomeSupport,
            isFromSupportScreen: arg["isFromSupportScreen"] ?? false,
          ),
        );

      case Routes.videoTrimmer:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;

        return _materialRoute(
          VideoTrimmerScreen(
            file: arg["video"] as File,
            maxDuration: arg["maxDuration"] as int,
          ),
        );
      case Routes.serviceDetailsCart:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          ServiceDetailsCartScreen(
            parentServiceName: arg['parentServiceName'] as String,
            serviceDetails: arg['serviceDetailsCart'] as HomeService,
            isFromHome: arg["isFromHome"] ?? false,
          ),
        );
      case Routes.notifications:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          NotificationsScreen(
            id: arg["id"] ?? -1,
          ),
        );
      case Routes.notificationsDetailsScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          NotificationDetailsScreen(
              isPushedNotification: arg["isPushedNotification"] as bool,
              notificationDetails: arg["details"] as NotificationItem,
              id: arg["id"] ?? -1),
        );
      case Routes.contactUs:
        return _materialRoute(
          const ContactUsScreen(),
        );
      case Routes.qrDetailsScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(QrDetailsScreen(
          qrId: arg["qrId"] as int,
        ));
      case Routes.register:
        return _materialRoute(
          const RegisterScreen(),
        );
      case Routes.compound:
        Compound selectedCompound = routeSettings.arguments as Compound;
        return _materialRoute(
          SelectCompoundScreen(
            selectedCompound: selectedCompound,
          ),
        );
      case Routes.qr:
        return _materialRoute(
          const QrScreen(),
        );

      // case Routes.servicesScreen:
      //   return _materialRoute(
      //     const ServicesScreen(),
      //   );
      case Routes.complain:
        return _materialRoute(
          const ComplainScreen(),
        );
      case Routes.payment:
        return _materialRoute(
          const PaymentScreen(),
        );

      case Routes.moreScreen:
        return _materialRoute(
          const MoreScreen(),
        );

      case Routes.delegatedStepsScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(DelegatedStepsScreen(
          isEdit: arg["isEdit"] as bool,
          delegatedData: arg["delegatedData"] as Delegated,
        ));
      case Routes.profile:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          ProfileScreen(
            index: arg["index"] as int,
            scrollId: arg["scrollToId"] as int,
          ),
        );
      case Routes.communityRequest:
        return _materialRoute(const CommunityRequestScreen());

      case Routes.commentScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          CommentsScreen(
            order: arg["order"] as Orders,
            id: arg["id"] as int,
          ),
        );
      case Routes.addUnit:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          AddUnitScreen(
            userId: arg["userId"] as int,
          ),
        );
      case Routes.resetPasswordScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(ResetPasswordScreen(
          phoneNumber: arg["phoneNumber"] as String,
          userId: arg["userId"] as int,
          invitationId: arg["invitationId"] as int,
          isFromDeepLink: arg["isFromDeepLink"] ?? false,
        ));
      case Routes.paymentDetails:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          PaymentDetailsScreen(
            paymentId: arg["paymentId"] as int,
          ),
        );
      case Routes.badgeIdentity:
        return _materialRoute(
          const BadgeIdentityScreen(),
        );
      case Routes.playVideoScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          PlayVideoScreen(
            video: arg["video"] as File,
            videoController:
                arg["videoPlayerController"] as VideoPlayerController,
          ),
        );
      case Routes.pdfScreen:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          PDFScreen(
            pdfLink: arg["link"] as String,
            screenTitle: arg["screenTitle"] as String,
            isNetworkPDF: arg["isNetworkPDF"] as bool? ?? true,
          ),
        );
      case Routes.myCart:
        Map<String, dynamic> arg =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          MyCartScreen(
            parentServiceName: arg['parentServiceName'] as String,
            servicesDetailsCart: arg["servicesDetailsCart"] ?? [],
            serviceDetails: arg["serviceDetails"] ?? const HomeService(),
            isFromHome: arg["isFromHome"] ?? false,
          ),
        );
      default:
        return _materialRoute(const SplashScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute(String name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: Center(
          child: Text("$name"),
        ),
      ),
    );
  }
}
