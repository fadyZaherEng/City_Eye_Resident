import 'package:json_annotation/json_annotation.dart';

part 'units_qr_code_day.g.dart';

@JsonSerializable()
class UnitsQrCodeDay {
  final int id;
  final String name;
  final String code;
  final int timeId;

  UnitsQrCodeDay({
    required this.id,
    required this.name,
    required this.code,
    required this.timeId,
  });

  factory UnitsQrCodeDay.fromJson(Map<String, dynamic> json) =>
      _$UnitsQrCodeDayFromJson(json);

  Map<String, dynamic> toJson() => _$UnitsQrCodeDayToJson(this);


}
