import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/request_support_multi_media.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/submit_support_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/support_details_date_request.dart';
import 'package:city_eye/src/domain/entities/support_details/prepared_visit_time.dart';
import 'package:city_eye/src/domain/entities/support_details/submit_support.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/comments_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/my_orders_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_cancel_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/order_rating_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/payment_url_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/send_comment_request.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:city_eye/src/domain/entities/support/payment_url.dart';
import 'package:city_eye/src/domain/entities/support_details/support_details_date.dart';


abstract interface class SupportRepository {
  Future<DataState<SupportDetailsDate>> getSupportDetailsDate(
      SupportDetailsDateRequest supportDetailsDateRequest);

  Future<DataState<SubmitSupport>> submitSupport(
      SubmitSupportRequest submitSupportRequest,
      SupportMultiMediaRequest supportMultiMediaRequest);

  Future<DataState<List<Orders>>> getMyOrders(MyOrdersRequest myOrdersRequest);

  Future<DataState> cancelOrder(OrderCancelRequest orderCancelRequest);

  Future<DataState<PaymentUrl>> getPaymentUrl(
      PaymentUrlRequest paymentUrlRequest);

  Future<DataState> sendOrderRating(OrderRatingRequest orderRatingRequest);

  Future<DataState<List<Comments>>> getOrderComments(
      CommentsRequest commentsRequest);

  Future<DataState<List<Comments>>> sendSupportComment(String imagePath,
      SendCommentRequest sendCommentRequest);
}