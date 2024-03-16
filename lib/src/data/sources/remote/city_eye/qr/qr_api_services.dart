import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_create_qr_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_configuration.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_details.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_history.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_history_with_answer.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/deactivate_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_history_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'qr_api_services.g.dart';

@RestApi()
abstract class QrAPIService {
  factory QrAPIService(Dio dio) = _QrAPIService;

  @POST(APIKeys.qrConfigurations)
  Future<HttpResponse<CityEyeResponse<RemoteQrConfiguration>>>
      getQrConfiguration(@Body() CityEyeRequest request);

  @POST(APIKeys.getQrCodeQuestions)
  Future<HttpResponse<CityEyeResponse<RemoteQrResponse>>> getQrCodeQuestions(
      @Body() CityEyeRequest request);

  @POST(APIKeys.saveQRCode)
  Future<HttpResponse<CityEyeResponse<RemoteCreateQrResponse>>> createQrCode(
    @Part(name: "Files") List<MultipartFile> files,
    @Part(name: 'requestHeader') String requestHeader,
  );

  @POST(APIKeys.qrHistory)
  Future<HttpResponse<CityEyeResponse<List<RemoteQrHistory>>>> getQrHistory(
      @Body() CityEyeRequest<QrHistoryRequest> qrHistoryRequest);

  @POST(APIKeys.deactivateQrHistory)
  Future<HttpResponse<CityEyeResponse<RemoteQrHistory>>> deactivateQrHistory(
      @Body() CityEyeRequest<DeactivateQrRequest> request);

  @POST(APIKeys.qrDetailsHistory)
  Future<HttpResponse<CityEyeResponse<RemoteQrDetails>>>
      getQrHistoryDetailsById(@Body() CityEyeRequest<QrDetailsRequest> request);
}
