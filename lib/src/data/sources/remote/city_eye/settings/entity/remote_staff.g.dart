// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteStaff _$RemoteStaffFromJson(Map<String, dynamic> json) => RemoteStaff(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      workingHours: json['workingHours'] as String? ?? "",
      mobile: json['mobile'] as String? ?? "",
      stuffJobType: json['stuffJobType'] == null
          ? const RemoteStaffJobType()
          : RemoteStaffJobType.fromJson(
              json['stuffJobType'] as Map<String, dynamic>),
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$RemoteStaffToJson(RemoteStaff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'workingHours': instance.workingHours,
      'stuffJobType': instance.stuffJobType,
      'image': instance.image,
    };
