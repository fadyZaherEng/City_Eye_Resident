import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/entity/remote_countery.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/contact_us/request/add_contact_us_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'contact_us_api_service.g.dart';

@RestApi()
abstract class ContactUsAPIService {
  factory ContactUsAPIService(Dio dio) = _ContactUsAPIService;

  @POST(APIKeys.getCountries)
  Future<HttpResponse<CityEyeResponse<List<RemoteCountry>>>> getCountries(
      @Body() CityEyeRequest request);

  @POST(APIKeys.addContactUs)
  Future<HttpResponse<CityEyeResponse>> addContactUs(
    @Body() CityEyeRequest<AddContactUsRequest> request,
  );
}
