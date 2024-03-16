import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/enable_disable_notifications.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class EnableDisableNotificationsUseCase {
  final SettingsRepository _settingsRepository;

  EnableDisableNotificationsUseCase(this._settingsRepository);

  Future<DataState> call(EnableDisableNotificationsRequest request) async =>
      await _settingsRepository.enableDisableNotificationsRequest(request);
}
