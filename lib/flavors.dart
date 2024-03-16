import 'package:city_eye/src/data/sources/remote/api_key.dart';

enum Flavor {
  development,
  production,
  nicetouchdevelopment,
  nicetouchproduction,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return APIKeys.baseUrlDevelopment;
      case Flavor.production:
        return APIKeys.baseUrlProduction;
      case Flavor.nicetouchdevelopment:
        return APIKeys.baseUrlGhadeerDevelopment;
      case Flavor.nicetouchproduction:
        return APIKeys.baseUrlGhadeerProduction;
      default:
        return APIKeys.baseUrlDevelopment;
    }
  }

  static String get brandingCode {
    switch (appFlavor) {
      case Flavor.development:
        return "CityEyeUser";
      case Flavor.production:
        return "CityEyeUser";
      case Flavor.nicetouchdevelopment:
        return "NiceTouchUser";
      case Flavor.nicetouchproduction:
        return "NiceTouchUser";
      default:
        return "CityEyeUser";
    }
  }

  static int get subscriberId {
    switch (appFlavor) {
      case Flavor.development:
        return 1;
      case Flavor.production:
        return 1;
      case Flavor.nicetouchdevelopment:
        return 2;
      case Flavor.nicetouchproduction:
        return 2;
      default:
        return 1;
    }
  }

  static bool get isNiceTouch {
    switch (appFlavor) {
      case Flavor.development:
        return false;
      case Flavor.production:
        return false;
      case Flavor.nicetouchdevelopment:
        return true;
      case Flavor.nicetouchproduction:
        return true;
      default:
        return false;
    }
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'City Eye Dev';
      case Flavor.production:
        return 'City Eye';
      case Flavor.nicetouchdevelopment:
        return 'Nice Touch Dev';
      case Flavor.nicetouchproduction:
        return 'Nice Touch';
      default:
        return 'title';
    }
  }

  static String get cityEye {
    switch (appFlavor) {
      case Flavor.development:
        return 'City Eye Dev';
      case Flavor.production:
        return 'City Eye';
      case Flavor.nicetouchdevelopment:
        return 'Nice Touch Dev';
      case Flavor.nicetouchproduction:
        return 'Nice Touch';
      default:
        return 'title';
    }
  }
}
