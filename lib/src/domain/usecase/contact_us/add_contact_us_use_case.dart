import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/request/add_contact_us_request.dart';
import 'package:city_eye/src/domain/repositories/contact_us_repository.dart';

final class AddContactUsUseCase {
  final ContactUsRepository _contactUsRepository;

  AddContactUsUseCase(this._contactUsRepository);

  Future<DataState> call(AddContactUsRequest request) async =>
      await _contactUsRepository.addContactUs(request);
}
