import 'dart:convert';

import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUserInformationUseCase {
  final SharedPreferences sharedPreferences;

  SaveUserInformationUseCase(this.sharedPreferences);

  Future<bool> call(User user) async {
    return await sharedPreferences.setString(SharedPreferenceKeys.user, jsonEncode(user.toMap()));
  }
}