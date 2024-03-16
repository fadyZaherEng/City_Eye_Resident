// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_support_details_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteSupportDetailsDate _$RemoteSupportDetailsDateFromJson(
        Map<String, dynamic> json) =>
    RemoteSupportDetailsDate(
      supportCategory: json['supportCategory'] == null
          ? const RemoteSupportCategory()
          : RemoteSupportCategory.fromJson(
              json['supportCategory'] as Map<String, dynamic>),
      compoundConfigration: json['compoundConfigration'] == null
          ? const RemoteCompoundConfiguration()
          : RemoteCompoundConfiguration.fromJson(
              json['compoundConfigration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteSupportDetailsDateToJson(
        RemoteSupportDetailsDate instance) =>
    <String, dynamic>{
      'supportCategory': instance.supportCategory,
      'compoundConfigration': instance.compoundConfigration,
    };
