import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_submit_support.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_support_date.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_support_details_date.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/support_details_date_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_comments.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_orders.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_payment_url.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/comments_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/my_orders_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_cancel_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_rating_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/payment_url_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'support_api_service.g.dart';

@RestApi()
abstract class SupportAPIService {
  factory SupportAPIService(Dio dio) = _SupportAPIService;

  @POST(APIKeys.myOrders)
  Future<HttpResponse<CityEyeResponse<List<RemoteOrders>>>> getMyOrders(
      @Body() CityEyeRequest<MyOrdersRequest> request);

  @POST(APIKeys.cancelOrder)
  Future<HttpResponse<CityEyeResponse>> cancelOrder(
      @Body() CityEyeRequest<OrderCancelRequest> request);

  @POST(APIKeys.getPaymentUrl)
  Future<HttpResponse<CityEyeResponse<RemotePaymentUrl>>> getPaymentUrl(
      @Body() CityEyeRequest<PaymentUrlRequest> request);

  @POST(APIKeys.orderRating)
  Future<HttpResponse<CityEyeResponse>> sendOrderRating(
      @Body() CityEyeRequest<OrderRatingRequest> request);

  @POST(APIKeys.getSupportComments)
  Future<HttpResponse<CityEyeResponse<List<RemoteComments>>>> getOrderComments(
      @Body() CityEyeRequest<CommentsRequest> request);

  @POST(APIKeys.sendSupportComment)
  Future<HttpResponse<CityEyeResponse<List<RemoteComments>>>>
      sendSupportComment(
    @Part(name: "requestHeader") String requestHeader,
    @Part(name: "image") List<MultipartFile> image,
  );

  @POST(APIKeys.supportDetailsDate)
  Future<HttpResponse<CityEyeResponse<RemoteSupportDetailsDate>>>
      getSupportDetailsDate(
    @Body() CityEyeRequest<SupportDetailsDateRequest> supportDetailsDateRequest,
  );

  @POST(APIKeys.submitSupportRequest)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteSubmitSupport>>> submitSupport(
    @Part(name: 'requestHeader') String requestHeader,
    @Part(name: "Files") List<MultipartFile> files,
  );
}
