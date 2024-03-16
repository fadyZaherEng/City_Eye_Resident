import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';

class GetOffersUseCase {
  final SettingsRepository _settingsRepository;

  GetOffersUseCase(this._settingsRepository);

  Future<DataState<List<Offer>>> call(OffersRequest offersRequest) async {
    return await _settingsRepository.getOffers(offersRequest);
  }
}
