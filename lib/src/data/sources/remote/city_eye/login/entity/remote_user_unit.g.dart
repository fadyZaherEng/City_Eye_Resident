// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUserUnit _$RemoteUserUnitFromJson(Map<String, dynamic> json) =>
    RemoteUserUnit(
      id: json['id'] as int? ?? 0,
      compoundId: json['compoundId'] as int? ?? 0,
      compoundName: json['compoundName'] as String? ?? "",
      unitId: json['unitId'] as int? ?? 0,
      unitNo: json['unitNo'] as String? ?? "",
      unitName: json['unitName'] as String? ?? "",
      compoundLogo: json['compoundLogo'] as String? ?? "",
      address: json['address'] as String? ?? "",
      isActive: json['isActive'] as bool? ?? false,
      userTypeId: json['userTypeId'] as int? ?? 0,
      userTypeName: json['userTypeName'] as String? ?? "",
      userUnitContractEndDate: json['userUnitContractEndDate'] as String? ?? "",
      isCompoundVerified: json['isCompoundVerified'] as bool? ?? false,
      lastMassage: json['lastMassage'] as String? ?? "",
      parents: (json['parents'] as List<dynamic>?)
              ?.map((e) =>
                  RemoteUserUnitParent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteUserUnitToJson(RemoteUserUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'compoundId': instance.compoundId,
      'compoundName': instance.compoundName,
      'unitId': instance.unitId,
      'unitNo': instance.unitNo,
      'unitName': instance.unitName,
      'compoundLogo': instance.compoundLogo,
      'address': instance.address,
      'isActive': instance.isActive,
      'userTypeId': instance.userTypeId,
      'userTypeName': instance.userTypeName,
      'userUnitContractEndDate': instance.userUnitContractEndDate,
      'isCompoundVerified': instance.isCompoundVerified,
      'lastMassage': instance.lastMassage,
      'parents': instance.parents,
    };
