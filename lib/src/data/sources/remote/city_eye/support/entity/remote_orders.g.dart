// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteOrders _$RemoteOrdersFromJson(Map<String, dynamic> json) => RemoteOrders(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String? ?? "",
      time: json['time'] as String? ?? "",
      isRating: json['isRating'] as bool? ?? false,
      ratingValue: json['ratingValue'] as int? ?? 0,
      ratingComment: json['ratingComment'] as String? ?? "",
      category: json['category'] == null
          ? const RemoteCategory()
          : RemoteCategory.fromJson(json['category'] as Map<String, dynamic>),
      statusList: (json['statusList'] as List<dynamic>?)
              ?.map((e) => RemoteStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      paymentId: json['paymentId'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteOrdersToJson(RemoteOrders instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'time': instance.time,
      'isRating': instance.isRating,
      'ratingValue': instance.ratingValue,
      'ratingComment': instance.ratingComment,
      'category': instance.category,
      'statusList': instance.statusList,
      'paymentId': instance.paymentId,
    };
