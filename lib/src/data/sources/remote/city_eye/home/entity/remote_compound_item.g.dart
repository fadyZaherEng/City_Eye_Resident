// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteHomeCompoundItem _$RemoteHomeCompoundItemFromJson(
        Map<String, dynamic> json) =>
    RemoteHomeCompoundItem(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? "",
      isVisible: json['isvisible'] as bool? ?? false,
    );

Map<String, dynamic> _$RemoteHomeCompoundItemToJson(
        RemoteHomeCompoundItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'isvisible': instance.isVisible,
    };
