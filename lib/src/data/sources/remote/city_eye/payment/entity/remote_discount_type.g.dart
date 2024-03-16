// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_discount_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteDiscountType _$RemoteDiscountTypeFromJson(Map<String, dynamic> json) =>
    RemoteDiscountType(
      id: json['id'] as int? ?? 0,
      type: json['type'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteDiscountTypeToJson(RemoteDiscountType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'code': instance.code,
    };
