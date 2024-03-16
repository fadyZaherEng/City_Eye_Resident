import 'dart:convert';

import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/domain/entities/sign_in/user.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUserUnitUseCase {
  final SharedPreferences sharedPreferences;

  SetUserUnitUseCase(this.sharedPreferences);

  Future<bool> call(UserUnit userUnit) async {
    return await sharedPreferences.setString(SharedPreferenceKeys.userUnit, jsonEncode(userUnit.toMap()));
  }
}