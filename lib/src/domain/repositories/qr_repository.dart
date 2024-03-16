import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/create_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/deactivate_qr_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_history_request.dart';
import 'package:city_eye/src/domain/entities/qr/create_qr_response.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qr_response.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_details.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:dio/dio.dart';

abstract class QrRepository {
  Future<DataState<QrConfiguration>> getQrConfiguration();

  Future<DataState<QrResponse>> getQrCodeQuestions();

  Future<DataState<CreateQrResponse>> createQrCode(
      CreateQrRequest createQrRequest);

  Future<DataState<List<QrHistory>>> getQrHistory(
      QrHistoryRequest qrHistoryRequest);

  Future<DataState<QrHistory>> deactivateQrHistory(
      DeactivateQrRequest deactivateQrRequest);

  Future<DataState<QrDetails>> getQrHistoryDetailsById(
      QrDetailsRequest qrDetailsRequest);
}
