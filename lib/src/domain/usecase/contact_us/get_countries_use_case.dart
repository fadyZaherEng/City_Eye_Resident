import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:city_eye/src/domain/repositories/contact_us_repository.dart';

final class GetCountriesUseCase {
  final ContactUsRepository _contactUsRepository;

  GetCountriesUseCase(this._contactUsRepository);

  Future<DataState<List<Country>>> call() async {
    return await _contactUsRepository.getCountries();
  }
}
