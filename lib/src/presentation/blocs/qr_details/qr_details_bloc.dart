import 'dart:async';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/core/utils/convert_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/qr_details_request.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_details.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:city_eye/src/domain/usecase/qr_details/get_qr_details_use_case.dart';
import 'package:city_eye/src/domain/usecase/qr_history/get_qr_details_history_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_details_event.dart';

part 'qr_details_state.dart';

class QrDetailsBloc extends Bloc<QrDetailsEvent, QrDetailsState> {
  final GetQrDetailsHistoryUseCase _getQrDetailsHistoryUseCase;

  QrDetailsBloc(this._getQrDetailsHistoryUseCase)
      : super(QrDetailsShowSkeletonState()) {
    on<GetQrDetailsDataEvent>(_onGetBarcodeSuccessDateEvent);
    on<QrDetailsBackEvent>(_onBarcodeSuccessBackEvent);
    on<QrDetailsShareQrEvent>(_onBarcodeSuccessShareQrEvent);
    on<QrDetailsDownloadQrEvent>(_onBarcodeSuccessDownloadQrEvent);
  }

  FutureOr<void> _onGetBarcodeSuccessDateEvent(
      GetQrDetailsDataEvent event, Emitter<QrDetailsState> emit) async {
    emit(QrDetailsShowSkeletonState());
    final qrDetailsState =
        await _getQrDetailsHistoryUseCase(QrDetailsRequest(id: event.qrId));
    if (qrDetailsState is DataSuccess<QrDetails>) {
      for (var i = 0;
          i < qrDetailsState.data!.qrHistoryWithQuestionAnswer.unitQRQuestionAnswers.length;
          i++) {
        if (qrDetailsState.data!.qrHistoryWithQuestionAnswer.unitQRQuestionAnswers[i].controlTypeCode ==
            QuestionsCode.date) {
          if (qrDetailsState.data!.qrHistoryWithQuestionAnswer.unitQRQuestionAnswers[i].value != "") {
            qrDetailsState.data!.qrHistoryWithQuestionAnswer.unitQRQuestionAnswers[i] =
                qrDetailsState.data!.qrHistoryWithQuestionAnswer.unitQRQuestionAnswers[i].copyWith(
              value: convertDateFormat(
                  qrDetailsState.data!.qrHistoryWithQuestionAnswer.unitQRQuestionAnswers[i].value),
            );
          }
        }
      }

      emit(SuccessGetQrDetailsDataState(
          qrDetailsState.data?.qrHistoryWithQuestionAnswer ?? QrHistoryWithQuestionAnswer()
      ));
    } else if (qrDetailsState is DataFailed) {
      emit(ErrorGetQrDetailsDataState(qrDetailsState.message ?? ""));
    }
  }

  FutureOr<void> _onBarcodeSuccessBackEvent(
      QrDetailsBackEvent event, Emitter<QrDetailsState> emit) {
    emit(QrDetailsBackState());
  }

  FutureOr<void> _onBarcodeSuccessShareQrEvent(
      QrDetailsShareQrEvent event, Emitter<QrDetailsState> emit) {
    emit(QrDetailsShareQrState());
  }

  FutureOr<void> _onBarcodeSuccessDownloadQrEvent(
      QrDetailsDownloadQrEvent event, Emitter<QrDetailsState> emit) {
    emit(QrDetailsDownloadQrState());
  }
}
