import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_guest_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_history_with_answer.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_status_qr_history.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_unit_qr_code_day.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_unit_qr_question_answer.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_details.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history_with_questions_answer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_details.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteQrDetails {
  final bool? isValid;
  @JsonKey(name: "qrCodeDetails")
  final RemoteQrHistoryWithAnswer? qrHistoryWithAnswer;

  const RemoteQrDetails({
    this.isValid = false,
    this.qrHistoryWithAnswer = const RemoteQrHistoryWithAnswer(),
  });

  factory RemoteQrDetails.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrDetailsToJson(this);
}

extension RemoteQrDetailsExtension on RemoteQrDetails? {
  QrDetails mapToDomain() => QrDetails(
        isValid: this!.isValid ?? false,
        qrHistoryWithQuestionAnswer:
        (this?.qrHistoryWithAnswer ?? RemoteQrHistoryWithAnswer()).mapToDomain(),
      );
}
