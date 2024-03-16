import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/unit_qr_question_answer.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/request/units_qr_code_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_qr_request.g.dart';

@JsonSerializable()
class CreateQrRequest {
  final int guestTypeId;
  final int qrTypeId;
  final String? fromDate;
  final String toDate;
  final String name;
  final String address;
  final int timeId;
  final List<UnitsQrCodeDay> unitsQrCodeDays;
  final List<UnitQrQuestionAnswer> unitQrQuestionAnswers;

  const CreateQrRequest({
    required this.guestTypeId,
    required this.qrTypeId,
    required this.fromDate,
    required this.toDate,
    required this.name,
    required this.address,
    required this.timeId,
    required this.unitsQrCodeDays,
    required this.unitQrQuestionAnswers,
  });

  factory CreateQrRequest.fromJson(Map<String, dynamic> json) => _$CreateQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQrRequestToJson(this);


}