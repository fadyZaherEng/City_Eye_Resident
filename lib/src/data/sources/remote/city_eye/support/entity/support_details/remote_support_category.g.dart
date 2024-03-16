// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_support_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSupportCategory _$RemoteSupportCategoryFromJson(
        Map<String, dynamic> json) =>
    RemoteSupportCategory(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      code: json['code'] as String? ?? "",
      isSupplier: json['isSupplier'] as bool? ?? false,
      supplier: json['supplier'] == null
          ? const RemoteSupplier()
          : RemoteSupplier.fromJson(json['supplier'] as Map<String, dynamic>),
      rules: json['rules'] == null
          ? const RemoteRules()
          : RemoteRules.fromJson(json['rules'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteSupportCategoryToJson(
        RemoteSupportCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'isSupplier': instance.isSupplier,
      'supplier': instance.supplier,
      'rules': instance.rules,
    };
