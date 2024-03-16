import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/service_details_cart_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/submit_service_details_cart_request.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:city_eye/src/domain/entities/service_details/submit_service_details_cart.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';

abstract interface class ServiceDetailsCartRepository {
  Future<DataState<List<ServiceDetailsCart>>> getServicePackages(
      ServiceDetailsCartRequest request);

  Future<DataState<List<MySubscription>>> getMySubscriptions();

  Future<DataState<SubmitServiceDetailsCart>> submitServiceDetailsCart(
      List<SubmitServiceDetailsCartRequest> submitServiceDetailsCartRequest);
}
