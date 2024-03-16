import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/login/entity/remote_user_unit.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_configration.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_gallery.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_language.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_lookup.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_offers.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_page.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_staff.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/enable_disable_notifications.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/gallery_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/lookup_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/offers_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_fields_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'settings_api_service.g.dart';

@RestApi()
abstract class SettingsAPIService {
  factory SettingsAPIService(Dio dio) = _SettingsAPIService;

  @POST(APIKeys.language)
  Future<HttpResponse<CityEyeResponse<List<RemoteLanguage>>>> getLanguage(
      @Body() CityEyeRequest request);

  @POST(APIKeys.lookup)
  Future<HttpResponse<CityEyeResponse<List<RemoteLookup>>>> getLookupData(
      @Body() CityEyeRequest<List<LookupRequest>> request);

  @POST(APIKeys.getPageFields)
  Future<HttpResponse<CityEyeResponse<List<RemotePage>>>> getPageFields(
      @Body() CityEyeRequest<PageFieldsRequest> request);

  @POST(APIKeys.getCompoundConfigration)
  Future<HttpResponse<CityEyeResponse<RemoteCompoundConfigration>>>
      getCompoundConfiguration(@Body() CityEyeRequest request);

  @POST(APIKeys.getCompoundStaff)
  Future<HttpResponse<CityEyeResponse<List<RemoteStaff>>>> getCompoundStaff(
      @Body() CityEyeRequest request);

  @POST(APIKeys.getOffers)
  Future<HttpResponse<CityEyeResponse<List<RemoteOffers>>>> getOffers(
      @Body() CityEyeRequest<OffersRequest> request);

  @POST(APIKeys.galleryList)
  Future<HttpResponse<CityEyeResponse<List<RemoteGallery>>>> getGallery(
      @Body() CityEyeRequest request);

  @POST(APIKeys.galleryDetails)
  Future<HttpResponse<CityEyeResponse<RemoteGallery>>> getGalleryDetails(
      @Body() CityEyeRequest<GalleryDetailsRequest> request);

  @POST(APIKeys.userUnits)
  Future<HttpResponse<CityEyeResponse<List<RemoteUserUnit>>>> getUserUnits(
      @Body() CityEyeRequest request);

  @POST(APIKeys.deleteUnit)
  Future<HttpResponse<CityEyeResponse>> deleteUnit(
      @Body() CityEyeRequest request);

  @POST(APIKeys.enableAndDisableNotifications)
  Future<HttpResponse<CityEyeResponse>> enableAndDisableNotifications(
      @Body() CityEyeRequest<EnableDisableNotificationsRequest> request);

  @POST(APIKeys.deleteAccount)
  Future<HttpResponse<CityEyeResponse>> deleteAccount(
      @Body() CityEyeRequest request);

  @POST(APIKeys.switchLanguage)
  Future<HttpResponse<CityEyeResponse<RemoteUserUnit>>> switchLanguage(
      @Body() CityEyeRequest request);
}
