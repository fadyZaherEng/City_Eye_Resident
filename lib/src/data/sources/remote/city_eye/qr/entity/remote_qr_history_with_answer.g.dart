// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_history_with_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrHistoryWithAnswer _$RemoteQrHistoryWithAnswerFromJson(
        Map<String, dynamic> json) =>
    RemoteQrHistoryWithAnswer(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      guestType: json['guestType'] == null
          ? const RemoteGuestType()
          : RemoteGuestType.fromJson(json['guestType'] as Map<String, dynamic>),
      status: json['status'] == null
          ? const RemoteStatusQrHistory()
          : RemoteStatusQrHistory.fromJson(
              json['status'] as Map<String, dynamic>),
      qrType: json['qrType'] == null
          ? const RemoteQrType()
          : RemoteQrType.fromJson(json['qrType'] as Map<String, dynamic>),
      fromDate: json['fromDate'] as String? ?? "",
      toDate: json['toDate'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      pdfUrl: json['pdfUrl'] as String? ?? "",
      shareLink: json['shareLink'] as String? ?? "",
      fromTime: json['fromTime'] as String? ?? "",
      toTime: json['toTime'] as String? ?? "",
      isEnabled: json['isEnabled'] as bool? ?? false,
      unitsQRCodeDays: (json['unitsQRCodeDays'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteUnitsQrCodeDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      unitQRQuestionAnswers: (json['unitQRQuestionAnswers'] as List<dynamic>?)
              ?.map((e) => RemoteUnitQrQuestionAnswer.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      qrMessage: json['qrMessage'] as String? ?? "",
      pinCode: json['pinCode'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteQrHistoryWithAnswerToJson(
        RemoteQrHistoryWithAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'guestType': instance.guestType?.toJson(),
      'status': instance.status?.toJson(),
      'qrType': instance.qrType?.toJson(),
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'imageUrl': instance.imageUrl,
      'pdfUrl': instance.pdfUrl,
      'shareLink': instance.shareLink,
      'isEnabled': instance.isEnabled,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
      'unitsQRCodeDays':
          instance.unitsQRCodeDays?.map((e) => e.toJson()).toList(),
      'unitQRQuestionAnswers':
          instance.unitQRQuestionAnswers.map((e) => e.toJson()).toList(),
      'qrMessage': instance.qrMessage,
      'pinCode': instance.pinCode,
    };
