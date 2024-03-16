import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_my_subscriptions.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_service_details_cart.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_submit_service_details_cart.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_details_cart_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'service_details_cart_api_service.g.dart';

@RestApi()
abstract class ServiceDetailsCartApiService {
  factory ServiceDetailsCartApiService(Dio dio) = _ServiceDetailsCartApiService;

  @POST(APIKeys.servicePackage)
  Future<HttpResponse<CityEyeResponse<List<RemoteServiceDetailsCart>>>>
      getServicePackages(
          @Body() CityEyeRequest<ServiceDetailsCartRequest> request);

  @POST(APIKeys.mySubscription)
  Future<HttpResponse<CityEyeResponse<List<RemoteMySubscriptions>>>>
      getMySubscriptions(@Body() CityEyeRequest request);

  @POST(APIKeys.submitServiceCart)
  Future<HttpResponse<CityEyeResponse<RemoteSubmitServiceDetailsCart>>>
      submitServiceDetailsCart(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "Files") List<MultipartFile> files,
  );
}
