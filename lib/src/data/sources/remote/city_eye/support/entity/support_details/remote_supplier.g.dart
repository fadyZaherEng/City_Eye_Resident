// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSupplier _$RemoteSupplierFromJson(Map<String, dynamic> json) =>
    RemoteSupplier(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteSupplierToJson(RemoteSupplier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
