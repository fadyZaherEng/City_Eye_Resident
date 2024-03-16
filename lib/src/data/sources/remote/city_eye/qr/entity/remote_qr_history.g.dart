// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_qr_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteQrHistory _$RemoteQrHistoryFromJson(Map<String, dynamic> json) =>
    RemoteQrHistory(
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
      fromTime: json['fromTime'] as String? ?? "",
      toTime: json['toTime'] as String? ?? "",
      createdDateStatus: json['createdDateStatus'] as String? ?? "",
      isEnabled: json['isEnabled'] as bool? ?? false,
      unitsQRCodeDays: (json['unitsQRCodeDays'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteUnitsQrCodeDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pinCode: json['pinCode'] as int? ?? 0,
      address: json['address'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteQrHistoryToJson(RemoteQrHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'guestType': instance.guestType?.toJson(),
      'status': instance.status?.toJson(),
      'qrType': instance.qrType?.toJson(),
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
      'createdDateStatus': instance.createdDateStatus,
      'isEnabled': instance.isEnabled,
      'unitsQRCodeDays':
          instance.unitsQRCodeDays?.map((e) => e.toJson()).toList(),
      'pinCode': instance.pinCode,
      'address': instance.address,
    };
