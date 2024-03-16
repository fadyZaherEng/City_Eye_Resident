// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundCurrency _$RemoteCompoundCurrencyFromJson(
        Map<String, dynamic> json) =>
    RemoteCompoundCurrency(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteCompoundCurrencyToJson(
        RemoteCompoundCurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
