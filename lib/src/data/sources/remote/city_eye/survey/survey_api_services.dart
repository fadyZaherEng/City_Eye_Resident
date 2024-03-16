import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_survey.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/survey/entity/remote_survey_question_choice.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'survey_api_services.g.dart';

@RestApi()
abstract class SurveyAPIServices {
  factory SurveyAPIServices(Dio dio) = _SurveyAPIServices;

  @POST(APIKeys.getSurveyList)
  Future<HttpResponse<CityEyeResponse<List<RemoteSurvey>>>> getSurveyList(
      @Body() CityEyeRequest request);

  @POST(APIKeys.submitSurvey)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteSurvey>>> submitSurvey(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "Files") List<MultipartFile> files,
  );
}
