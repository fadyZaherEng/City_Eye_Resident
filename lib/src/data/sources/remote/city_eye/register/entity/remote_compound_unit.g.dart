// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundUnit _$RemoteCompoundUnitFromJson(Map<String, dynamic> json) =>
    RemoteCompoundUnit(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      units: (json['units'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteCompoundUnit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteCompoundUnitToJson(RemoteCompoundUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'units': instance.units,
    };
