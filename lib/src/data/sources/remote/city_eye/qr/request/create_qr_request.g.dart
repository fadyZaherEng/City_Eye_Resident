// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_qr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateQrRequest _$CreateQrRequestFromJson(Map<String, dynamic> json) =>
    CreateQrRequest(
      guestTypeId: json['guestTypeId'] as int,
      qrTypeId: json['qrTypeId'] as int,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      timeId: json['timeId'] as int,
      unitsQrCodeDays: (json['unitsQrCodeDays'] as List<dynamic>)
          .map((e) => UnitsQrCodeDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitQrQuestionAnswers: (json['unitQrQuestionAnswers'] as List<dynamic>)
          .map((e) => UnitQrQuestionAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateQrRequestToJson(CreateQrRequest instance) =>
    <String, dynamic>{
      'guestTypeId': instance.guestTypeId,
      'qrTypeId': instance.qrTypeId,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'name': instance.name,
      'address': instance.address,
      'timeId': instance.timeId,
      'unitsQrCodeDays': instance.unitsQrCodeDays,
      'unitQrQuestionAnswers': instance.unitQrQuestionAnswers,
    };
