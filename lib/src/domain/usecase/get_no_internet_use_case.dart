import 'dart:ui';

import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetNoInternetUseCase {
  final SharedPreferences sharedPreferences;

  GetNoInternetUseCase(this.sharedPreferences);

  bool call() {
    return sharedPreferences.getBool(SharedPreferenceKeys.noInternet) ?? false;
  }
}
