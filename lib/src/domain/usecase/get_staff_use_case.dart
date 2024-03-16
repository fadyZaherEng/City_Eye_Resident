import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

final class GetStaffUseCase {
  final SettingsRepository _settingsRepository;

  GetStaffUseCase(this._settingsRepository);

  Future<DataState<List<Staff>>> call() async =>
      await _settingsRepository.getCompoundStaff();
}
