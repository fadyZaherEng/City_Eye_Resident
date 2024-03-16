import 'dart:convert';

import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserUnitUseCase {
  final SharedPreferences sharedPreferences;

  GetUserUnitUseCase(this.sharedPreferences);

  UserUnit call() {
    return sharedPreferences.getString(SharedPreferenceKeys.userUnit) == null
        ? const UserUnit()
        : UserUnit.fromMap(jsonDecode(
            sharedPreferences.getString(SharedPreferenceKeys.userUnit) ?? ""));
  }
}
