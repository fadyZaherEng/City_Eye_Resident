import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_guest_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_status_qr_history.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_unit_qr_code_day.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_unit_qr_question_answer.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_history_with_answer.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteQrHistoryWithAnswer {
  final int? id;
  final String? name;
  final RemoteGuestType? guestType;
  final RemoteStatusQrHistory? status;
  final RemoteQrType? qrType;
  final String? fromDate;
  final String? toDate;
  final String? imageUrl;
  final String? pdfUrl;
  final String? shareLink;
  final bool? isEnabled;
  final String? fromTime;
  final String? toTime;
  final List<RemoteUnitsQrCodeDay>? unitsQRCodeDays;
  final List<RemoteUnitQrQuestionAnswer> unitQRQuestionAnswers;
  final String? qrMessage;
  final int? pinCode;

  const RemoteQrHistoryWithAnswer({
    this.id = 0,
    this.name = "",
    this.guestType = const RemoteGuestType(),
    this.status = const RemoteStatusQrHistory(),
    this.qrType = const RemoteQrType(),
    this.fromDate = "",
    this.toDate = "",
    this.imageUrl = "",
    this.pdfUrl = "",
    this.shareLink = "",
    this.fromTime = "",
    this.toTime = "",
    this.isEnabled = false,
    this.unitsQRCodeDays = const [],
    this.unitQRQuestionAnswers = const [],
    this.qrMessage = "",
    this.pinCode = 0,
  });

  factory RemoteQrHistoryWithAnswer.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrHistoryWithAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrHistoryWithAnswerToJson(this);
}

extension RemoteQrHistoryWithAnswerExtension on RemoteQrHistoryWithAnswer? {
  QrHistoryWithQuestionAnswer mapToDomain() => QrHistoryWithQuestionAnswer(
        id: this!.id ?? 0,
        name: this!.name ?? "",
        guestType: this!.guestType!.mapToDomain(),
        status: this!.status!.mapToDomain(),
        qrType: this!.qrType!.mapToDomain(),
        fromDate: this!.fromDate ?? "",
        toDate: this!.toDate ?? "",
        isEnabled: this!.isEnabled ?? false,
        unitsQrCodeDays: this!.unitsQRCodeDays.mapToDomain(),
        unitQRQuestionAnswers: this!.unitQRQuestionAnswers.mapToDomain(),
        imageUrl: this!.imageUrl ?? "",
        pdfUrl: this!.pdfUrl ?? "",
        shareLink: this!.shareLink ?? "",
        fromTime: this!.fromTime ?? "",
        toTime: this!.toTime ?? "",
        qrMessage: this!.qrMessage ?? "",
        pinCode: this!.pinCode ?? 0,
      );
}
