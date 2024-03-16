import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_day.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_holiday.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_question.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qrs_type.dart';
import 'package:city_eye/src/domain/entities/qr/guests_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_guests_type.g.dart';

@JsonSerializable()
class RemoteGuestsType {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'checkHoliday')
  final bool? isHoliday;
  @JsonKey(name: 'checkWeekend')
  final bool? isWeekend;
  @JsonKey(name: 'isRestricted')
  final bool? isRestricted;
  @JsonKey(name: 'questions')
  final List<RemoteQrQuestion>? questions;
  @JsonKey(name: 'qrTypes')
  final List<RemoteQrsType>? types;
  @JsonKey(name: 'guestTypeDays')
  final List<RemoteDay>? days;
  @JsonKey(name: 'rules')
  final String rules;
  @JsonKey(name: 'periodRequest')
  final String qrPeriodRequest;

  const RemoteGuestsType({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.isHoliday = false,
    this.isWeekend = false,
    this.isRestricted = false,
    this.questions = const [],
    this.types = const [],
    this.days = const [],
    this.rules = "",
    this.qrPeriodRequest = "",
  });

  factory RemoteGuestsType.fromJson(Map<String, dynamic> json) =>
      _$RemoteGuestsTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteGuestsTypeToJson(this);
}

extension RemoteGuestsTypeExtension on RemoteGuestsType? {
  GuestsType mapToDomain() {
    return GuestsType(
      id: this?.id ?? 0,
      name: this?.name ?? "",
      code: this?.code ?? "",
      isHoliday: this?.isHoliday ?? false,
      isWeekend: this?.isWeekend ?? false,
      isRestricted: this?.isRestricted ?? false,
      questions:
          this?.questions?.map((e) => e.mapToDomain()).toList() ?? [],
      qrTypes: this?.types?.map((e) => e.mapToDomain()).toList() ?? [],
      days: this?.days?.map((e) => e.mapToDomain()).toList() ?? [],
      rules: this?.rules ?? "",
      qrPeriodRequest: this?.qrPeriodRequest ?? "",
      iseSelected: false,
    );
  }
}

extension RemoteGuestsTypesExtension on List<RemoteGuestsType>? {
  List<GuestsType> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
