import 'dart:io';

import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/entity/remote_payment.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/payment_api_service.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/payment/request/payment_request.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/repositories/payment_repository.dart';
import 'package:dio/dio.dart';

final class PaymentRepositoryImplementation implements PaymentRepository {
  final PaymentAPIService _cityEyeAPIService;

  PaymentRepositoryImplementation(this._cityEyeAPIService);

  @override
  Future<DataState<List<Payment>>> getPayments() async {
    try {
      final request = CityEyeRequest().createRequest(null);
      final httpResponse = await _cityEyeAPIService.getPayments(request);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            httpResponse.data.statusCode == 200) {
          return DataSuccess(
            data: (httpResponse.data.result ?? const []).mapToDomain,
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<String>> getPaymentUrl(PaymentRequest paymentRequest) async {
    try {
      final request =
          CityEyeRequest<PaymentRequest>().createRequest(paymentRequest);
      final httpResponse = await _cityEyeAPIService.getPaymentUrl(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            httpResponse.data.statusCode == 200) {
          return DataSuccess(
            data: httpResponse.data.result ?? "",
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }

  @override
  Future<DataState<Payment>> getPaymentDetails(
      PaymentDetailsRequest paymentDetailsRequest) async {
    try {
      final request = CityEyeRequest<PaymentDetailsRequest>()
          .createRequest(paymentDetailsRequest);
      final httpResponse = await _cityEyeAPIService.getPaymentDetails(request);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if ((httpResponse.data.success ?? false) &&
            httpResponse.data.statusCode == 200) {
          return DataSuccess(
            data:
                (httpResponse.data.result ?? const RemotePayment()).mapToDomain,
            message: httpResponse.data.responseMessage ?? "",
          );
        }
      }
      return DataFailed(
        message: httpResponse.data.responseMessage ?? "",
      );
    } on DioException catch (e) {
      return DataFailed(
        error: e,
        message: S.current.badResponse,
      );
    }
  }
}
