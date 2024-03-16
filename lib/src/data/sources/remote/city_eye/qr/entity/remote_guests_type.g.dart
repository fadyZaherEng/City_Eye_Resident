// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_guests_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteGuestsType _$RemoteGuestsTypeFromJson(Map<String, dynamic> json) =>
    RemoteGuestsType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      isHoliday: json['checkHoliday'] as bool? ?? false,
      isWeekend: json['checkWeekend'] as bool? ?? false,
      isRestricted: json['isRestricted'] as bool? ?? false,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => RemoteQrQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      types: (json['qrTypes'] as List<dynamic>?)
              ?.map((e) => RemoteQrsType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      days: (json['guestTypeDays'] as List<dynamic>?)
              ?.map((e) => RemoteDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rules: json['rules'] as String? ?? "",
      qrPeriodRequest: json['periodRequest'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteGuestsTypeToJson(RemoteGuestsType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'checkHoliday': instance.isHoliday,
      'checkWeekend': instance.isWeekend,
      'isRestricted': instance.isRestricted,
      'questions': instance.questions,
      'qrTypes': instance.types,
      'guestTypeDays': instance.days,
      'rules': instance.rules,
      'periodRequest': instance.qrPeriodRequest,
    };
