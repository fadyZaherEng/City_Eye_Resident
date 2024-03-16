import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/enable_disable_notifications.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/gallery_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/offers/offer.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery.dart';
import 'package:city_eye/src/domain/entities/settings/language.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart';
import 'package:city_eye/src/domain/entities/sign_in/user_unit.dart';
import 'package:city_eye/src/domain/entities/staff/staff.dart';

abstract class SettingsRepository {
  Future<DataState<List<Language>>> getLanguage();

  Future<DataState<List<Lookup>>> getLookupData(List<LookupRequest> requests);

  Future<DataState<List<Page>>> getPageFields(
      PageFieldsRequest pageFieldsRequest);

  Future<DataState<CompoundConfiguration>> getCompoundConfigration();

  Future<DataState<List<Staff>>> getCompoundStaff();

  Future<DataState<List<Offer>>> getOffers(OffersRequest offersRequest);

  Future<DataState<List<Gallery>>> getGallery();

  Future<DataState<Gallery>> getGalleryDetails(GalleryDetailsRequest request);

  Future<DataState<List<UserUnit>>> getUserUnits();

  Future<DataState<String>> deleteUnit();

  Future<DataState<String>> deleteAccount();

  Future<DataState> enableDisableNotificationsRequest(
      EnableDisableNotificationsRequest enableDisableNotificationsRequest);

  Future<DataState<UserUnit>> switchLanguage();
}
