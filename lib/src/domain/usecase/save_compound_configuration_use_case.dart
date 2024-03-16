import 'dart:convert';

import 'package:city_eye/src/core/resources/shared_preferences_keys.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SaveCompoundConfigurationUseCase {
  final SharedPreferences _sharedPreferences;

  SaveCompoundConfigurationUseCase(this._sharedPreferences);

  Future<bool> call(CompoundConfiguration compoundConfiguration) async =>
      await _sharedPreferences.setString(SharedPreferenceKeys.compoundConfiguration, jsonEncode(compoundConfiguration.toMap()));
}
