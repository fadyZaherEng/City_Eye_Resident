import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/entity/remote_wall.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/wall/request/wall_details_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'wall_api_service.g.dart';

@RestApi()
abstract class WallAPIService {
  factory WallAPIService(Dio dio) = _WallAPIService;

  @POST(APIKeys.wallList)
  Future<HttpResponse<CityEyeResponse<List<RemoteWall>>>> getWallList(
      @Body() CityEyeRequest request);

  @POST(APIKeys.wallDetails)
  Future<HttpResponse<CityEyeResponse<RemoteWall>>> getWallDetails(
      @Body() CityEyeRequest<WallDetailsRequest> request);
}
