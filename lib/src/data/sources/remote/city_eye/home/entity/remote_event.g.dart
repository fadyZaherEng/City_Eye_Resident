// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteEvent _$RemoteEventFromJson(Map<String, dynamic> json) => RemoteEvent(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      startDate: json['startDate'] as String? ?? "",
      endDate: json['endDate'] as String? ?? "",
      openingDate: json['openingDate'] as String? ?? "",
      closedDate: json['closedDate'] as String? ?? "",
      isPaid: json['isPaid'] as bool? ?? false,
      maxCountJoin: json['maxCountJoin'] as int? ?? 0,
      memberCount: json['memberCount'] as int? ?? 0,
      memberPrice: json['memberPrice'] as int? ?? 0,
      locationAddress: json['locationAddress'] as String? ?? "",
      locationLatitude: json['locationLatitude'] as String? ?? "",
      locationLongitude: json['locationLongitude'] as String? ?? "",
      transactionId: json['transactionId'] as int? ?? 0,
      calenderRef: json['calenderRef'] as String? ?? "",
      eventsOptions: (json['eventsOptions'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteHomeEventOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      eventsRules: (json['eventsRules'] as List<dynamic>?)
              ?.map((e) => RemoteEventRules.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      eventsAttachments: (json['eventsAttachments'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteEventAttachments.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteEventToJson(RemoteEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'openingDate': instance.openingDate,
      'closedDate': instance.closedDate,
      'isPaid': instance.isPaid,
      'memberCount': instance.memberCount,
      'maxCountJoin': instance.maxCountJoin,
      'memberPrice': instance.memberPrice,
      'locationAddress': instance.locationAddress,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
      'transactionId': instance.transactionId,
      'calenderRef': instance.calenderRef,
      'eventsOptions': instance.eventsOptions,
      'eventsRules': instance.eventsRules,
      'eventsAttachments': instance.eventsAttachments,
    };
