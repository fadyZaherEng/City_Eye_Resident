import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/entity/remote_complain.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/request/submit_complain_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'complain_api_service.g.dart';

@RestApi()
abstract class ComplainAPIService {
  factory ComplainAPIService(Dio dio) = _ComplainAPIService;

  @POST(APIKeys.submitComplain)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteComplain>>> submitComplain(
    @Part(name: "Files") List<MultipartFile> files,
    @Part(name: 'requestHeader') String requestHeader,
  );
}
