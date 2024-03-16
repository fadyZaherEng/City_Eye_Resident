import 'package:city_eye/src/domain/entities/qr_history/guest_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/status.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_code_day.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_question_answer.dart';
import 'package:equatable/equatable.dart';

class QrHistoryWithQuestionAnswer extends Equatable {
  final int id;
  final String name;
  final GuestTypeQrHistory guestType;
  final StatusQrHistory status;
  final QrTypeQrHistory qrType;
  final String fromDate;
  final String toDate;
  final String imageUrl;
  final String pdfUrl;
  final String shareLink;
  final String fromTime;
  final String toTime;
  final bool isEnabled;
  final List<UnitsQrCodeDay> unitsQrCodeDays;
  final List<UnitQrQuestionAnswer> unitQRQuestionAnswers;
  final String qrMessage;
  final int pinCode;

  const QrHistoryWithQuestionAnswer({
    this.id = 0,
    this.name = "",
    this.guestType = const GuestTypeQrHistory(),
    this.status = const StatusQrHistory(),
    this.qrType = const QrTypeQrHistory(),
    this.fromDate = "",
    this.toDate = "",
    this.fromTime = "",
    this.toTime = "",
    this.imageUrl = "",
    this.pdfUrl = "",
    this.shareLink = "",
    this.isEnabled = false,
    this.unitsQrCodeDays = const [],
    this.unitQRQuestionAnswers = const [],
    this.qrMessage = "",
    this.pinCode = 0,
  });

  @override
  List<Object> get props => [
        id,
        name,
        guestType,
        status,
        qrType,
        fromDate,
        toDate,
        imageUrl,
        pdfUrl,
        shareLink,
        isEnabled,
        unitsQrCodeDays,
        unitQRQuestionAnswers,
        fromTime,
        toTime,
        qrMessage,
        pinCode,
      ];

  QrHistoryWithQuestionAnswer copyWith({
    int? id,
    String? name,
    GuestTypeQrHistory? guestType,
    StatusQrHistory? status,
    QrTypeQrHistory? qrType,
    String? fromDate,
    String? toDate,
    String? imageUrl,
    String? pdfUrl,
    String? fromTime,
    String? toTime,
    String? shareLink,
    bool? isEnabled,
    List<UnitsQrCodeDay>? unitsQrCodeDays,
    List<UnitQrQuestionAnswer>? unitQRQuestionAnswers,
    String? qrMessage,
    int? pinCode,
  }) {
    return QrHistoryWithQuestionAnswer(
      id: id ?? this.id,
      name: name ?? this.name,
      guestType: guestType ?? this.guestType,
      status: status ?? this.status,
      qrType: qrType ?? this.qrType,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      imageUrl: imageUrl ?? this.imageUrl,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      shareLink: shareLink ?? this.shareLink,
      isEnabled: isEnabled ?? this.isEnabled,
      unitsQrCodeDays: unitsQrCodeDays ?? this.unitsQrCodeDays,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      unitQRQuestionAnswers:
          unitQRQuestionAnswers ?? this.unitQRQuestionAnswers,
      qrMessage: qrMessage ?? this.qrMessage,
      pinCode: pinCode ?? this.pinCode,
    );
  }
}
