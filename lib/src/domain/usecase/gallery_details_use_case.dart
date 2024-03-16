import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/gallery_request.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

final class GalleryDetailsUseCase {
  final SettingsRepository _settingsRepository;

  GalleryDetailsUseCase(this._settingsRepository);

  Future<DataState<Gallery>> call(GalleryDetailsRequest request) async =>
      await _settingsRepository.getGalleryDetails(request);
}
