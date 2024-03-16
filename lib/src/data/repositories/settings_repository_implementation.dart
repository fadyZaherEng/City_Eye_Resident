import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_unit.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_configration.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_gallery.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_language.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_lookup.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_offers.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_page.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/enable_disable_notifications.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_staff.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/gallery_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/settings_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';
import 'package:city_eye/src/domain/repositories/settings_repository.dart';
import 'package:dio/dio.dart';

class SettingsRepositoryImplementation extends SettingsRepository {
  final SettingsAPIService _settingsAPIService;

  SettingsRepositoryImplementation(this._settingsAPIService);

  @override
  Future<DataState<List<Language>>> getLanguage() async {
    try {
      CityEyeRequest request = await CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.getLanguage(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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
  Future<DataState<List<Lookup>>> getLookupData(
      List<LookupRequest> requests) async {
    try {
      CityEyeRequest<List<LookupRequest>> request =
          CityEyeRequest<List<LookupRequest>>().createRequest(requests);
      final httpResponse = await _settingsAPIService.getLookupData(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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
  Future<DataState<List<Page>>> getPageFields(
      PageFieldsRequest pageFieldsRequest) async {
    try {
      CityEyeRequest<PageFieldsRequest> request =
          CityEyeRequest<PageFieldsRequest>().createRequest(pageFieldsRequest);
      final httpResponse = await _settingsAPIService.getPageFields(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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
  Future<DataState<CompoundConfiguration>> getCompoundConfigration() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse =
          await _settingsAPIService.getCompoundConfiguration(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          final DataState<CompoundConfiguration> successState =
              DataSuccess<CompoundConfiguration>(
            data:
                (httpResponse.data.result ?? const RemoteCompoundConfigration())
                    .mapToDomain,
            message: httpResponse.data.responseMessage ?? "",
          );
          return successState;
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
  Future<DataState<List<Offer>>> getOffers(OffersRequest offersRequest) async {
    try {
      CityEyeRequest<OffersRequest> request =
          CityEyeRequest<OffersRequest>().createRequest(offersRequest);
      final httpResponse = await _settingsAPIService.getOffers(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain(),
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
  Future<DataState<List<Staff>>> getCompoundStaff() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.getCompoundStaff(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            (httpResponse.data.statusCode ?? 400) == 200) {
          final DataSuccess<List<Staff>> dataSuccess = DataSuccess<List<Staff>>(
            data: (httpResponse.data.result ?? []).mapToDomain(),
            message: httpResponse.data.responseMessage ?? "",
          );
          return dataSuccess;
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

  Future<DataState<List<Gallery>>> getGallery() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.getGallery(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState<List<Gallery>> successState =
            DataSuccess<List<Gallery>>(
          message: httpResponse.data.responseMessage ?? "",
          data: (httpResponse.data.result ?? []).mapToDomain,
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<Gallery>> getGalleryDetails(
      GalleryDetailsRequest request) async {
    try {
      final CityEyeRequest<GalleryDetailsRequest> request =
          CityEyeRequest<GalleryDetailsRequest>()
              .createRequest(GalleryDetailsRequest);
      final httpResponse = await _settingsAPIService.getGalleryDetails(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState<Gallery> successState = DataSuccess<Gallery>(
          data: (httpResponse.data.result ?? RemoteGallery()).mapToDomain,
          message: httpResponse.data.responseMessage ?? "",
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<List<UserUnit>>> getUserUnits() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.getUserUnits(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState<List<UserUnit>> successState =
            DataSuccess<List<UserUnit>>(
          message: httpResponse.data.responseMessage ?? "",
          data: (httpResponse.data.result ?? []).mapToDomain(),
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<String>> deleteUnit() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.deleteUnit(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState<String> successState = DataSuccess<String>(
          message: httpResponse.data.responseMessage ?? "",
          data: "",
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState> enableDisableNotificationsRequest(
      EnableDisableNotificationsRequest
          enableDisableNotificationsRequest) async {
    try {
      final CityEyeRequest<EnableDisableNotificationsRequest> request =
          CityEyeRequest<EnableDisableNotificationsRequest>()
              .createRequest(enableDisableNotificationsRequest);
      final httpResponse =
          await _settingsAPIService.enableAndDisableNotifications(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState successState = DataSuccess(
          message: httpResponse.data.responseMessage ?? "",
          data: "",
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<String>> deleteAccount() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.deleteAccount(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState<String> successState = DataSuccess<String>(
          message: httpResponse.data.responseMessage ?? "",
          data: "",
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<UserUnit>> switchLanguage() async {
    try {
      final CityEyeRequest request = CityEyeRequest().createRequest(null);
      final httpResponse = await _settingsAPIService.switchLanguage(request);
      if ((httpResponse.data.statusCode ?? 400) == 200 &&
          (httpResponse.data.success ?? false)) {
        final DataState<UserUnit> successState = DataSuccess<UserUnit>(
          message: httpResponse.data.responseMessage ?? "",
          data: (httpResponse.data.result ?? const RemoteUserUnit())
              .mapUnitSwitchLanguageToDomain(),
        );
        return successState;
      }
      return DataFailed(message: httpResponse.data.responseMessage ?? "");
    } on DioException catch (error) {
      return DataFailed(
        error: error,
        message: S.current.badResponse,
      );
    }
  }
}
