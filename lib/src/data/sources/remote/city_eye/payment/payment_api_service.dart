import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_api_service.g.dart';

@RestApi()
abstract class PaymentAPIService {
  factory PaymentAPIService(Dio dio) = _PaymentAPIService;

  @POST(APIKeys.payment)
  Future<HttpResponse<CityEyeResponse<List<RemotePayment>>>> getPayments(
      @Body() CityEyeRequest request);

  @POST(APIKeys.paymentUrl)
  Future<HttpResponse<CityEyeResponse<String>>> getPaymentUrl(
      @Body() CityEyeRequest<PaymentRequest> request);

  @POST(APIKeys.paymentDetails)
  Future<HttpResponse<CityEyeResponse<RemotePayment>>> getPaymentDetails(
      @Body() CityEyeRequest<PaymentDetailsRequest> request);
}
