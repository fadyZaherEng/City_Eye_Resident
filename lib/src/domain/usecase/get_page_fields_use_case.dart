import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class GetPageFieldsUseCase {
  final SettingsRepository _settingsRepository;

  GetPageFieldsUseCase(this._settingsRepository);

  Future<DataState<List<Page>>> call(PageFieldsRequest pageFieldsRequest) async {
    return await _settingsRepository.getPageFields(pageFieldsRequest);
  }
}