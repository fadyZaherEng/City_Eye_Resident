// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCurrency _$RemoteCurrencyFromJson(Map<String, dynamic> json) =>
    RemoteCurrency(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCurrencyToJson(RemoteCurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
