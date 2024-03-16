import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/contact_us_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/entity/remote_countery.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/request/add_contact_us_request.dart';
import 'package:city_eye/src/domain/entities/contact_us/country.dart';
import 'package:city_eye/src/domain/repositories/contact_us_repository.dart';
import 'package:dio/dio.dart';

final class ContactUsRepositoryImplementation implements ContactUsRepository {
  final ContactUsAPIService _contactUsAPIService;

  ContactUsRepositoryImplementation(this._contactUsAPIService);

  @override
  Future<DataState<List<Country>>> getCountries() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse = await _contactUsAPIService.getCountries(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain,
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState> addContactUs(AddContactUsRequest request) async {
    try {
      final addContactUsRequest =
          CityEyeRequest<AddContactUsRequest>().createRequest(request);
      final httpResponse =
          await _contactUsAPIService.addContactUs(addContactUsRequest);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
