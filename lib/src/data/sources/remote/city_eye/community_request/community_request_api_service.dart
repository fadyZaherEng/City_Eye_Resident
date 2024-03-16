import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/community_request/entity/remote_submit_community.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../city_eye_response.dart';

part 'community_request_api_service.g.dart';

@RestApi()
abstract class CommunityRequestAPIService {

  factory CommunityRequestAPIService(Dio dio) = _CommunityRequestAPIService;

  @POST(APIKeys.submitCommunityRequest)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteSubmitCommunity>>> submitCommunityRequest(
      @Part(name: "Files") List<MultipartFile> files,
      @Part(name: 'requestHeader') String requestHeader,
      );

}