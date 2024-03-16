import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/request/add_contact_us_request.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';

abstract interface class ContactUsRepository {
  Future<DataState<List<Country>>> getCountries();

  Future<DataState> addContactUs(AddContactUsRequest request);
}
