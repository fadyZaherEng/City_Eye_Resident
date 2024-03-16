import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class GetUserUnitsUseCase {
  final SettingsRepository _settingsRepository;

  GetUserUnitsUseCase(this._settingsRepository);

  Future<DataState<List<UserUnit>>> call() async {
    return await _settingsRepository.getUserUnits();
  }
}
