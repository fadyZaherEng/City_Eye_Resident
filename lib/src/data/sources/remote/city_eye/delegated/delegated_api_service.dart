import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/entity/remote_delegated.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/entity/remote_submit_delegation.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delete_delegated_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'delegated_api_service.g.dart';

@RestApi()
abstract class DelegatedAPIService {
  factory DelegatedAPIService(Dio dio) = _DelegatedAPIService;

  @POST(APIKeys.getDelegatedList)
  Future<HttpResponse<CityEyeResponse<List<RemoteDelegated>>>> getDelegatedList(
      @Body() CityEyeRequest request);

  @POST(APIKeys.deleteDelegated)
  Future<HttpResponse<CityEyeResponse>> deleteDelegated(
      @Body() CityEyeRequest<DeleteDelegatedRequest> request);

  @POST(APIKeys.submitDelegation)
  Future<HttpResponse<CityEyeResponse<RemoteSubmitDelegation>>> submitDelegation(
    @Part(name: "Files") List<MultipartFile> files,
    @Part(name: 'requestHeader') String requestHeader,
  );
}
