import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

final class GalleryUseCase {
  final SettingsRepository _settingsRepository;

  GalleryUseCase(this._settingsRepository);

  Future<DataState<List<Gallery>>> call() async =>
      await _settingsRepository.getGallery();
}
