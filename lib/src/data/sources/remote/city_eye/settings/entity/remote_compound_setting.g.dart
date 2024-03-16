// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_compound_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCompoundSetting _$RemoteCompoundSettingFromJson(
        Map<String, dynamic> json) =>
    RemoteCompoundSetting(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      compoundType: json['compoundType'] == null
          ? const RemoteCompoundType()
          : RemoteCompoundType.fromJson(
              json['compoundType'] as Map<String, dynamic>),
      owner: json['owner'] as String? ?? "",
      mobile: json['mobile'] as String? ?? "",
      email: json['email'] as String? ?? "",
      latitude: json['latitude'] as String? ?? "",
      longitude: json['longitude'] as String? ?? "",
      address: json['address'] as String? ?? "",
      logo: json['logo'] as String? ?? "",
      termsConditions: json['termsConditions'] as String? ?? "",
      currency: json['currency'] == null
          ? const RemoteCompoundCurrency()
          : RemoteCompoundCurrency.fromJson(
              json['currency'] as Map<String, dynamic>),
      aboutUs: json['aboutUs'] as String? ?? "",
      faq: json['faq'] as String? ?? "",
      communityRules: json['communityRules'] as String? ?? "",
      isIncludeTax: json['isIncludeTax'] as bool? ?? false,
      isIncludeVat: json['isIncludeVat'] as bool? ?? false,
      otpRequestCount: json['otpRequestCount'] as int? ?? 0,
      otpLimitationMinutes: json['otpLimitationMinutes'] as int? ?? 0,
      badgeExpiredTime: json['badgeExpiredTime'] as int? ?? 0,
    );

Map<String, dynamic> _$RemoteCompoundSettingToJson(
        RemoteCompoundSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'compoundType': instance.compoundType?.toJson(),
      'owner': instance.owner,
      'mobile': instance.mobile,
      'email': instance.email,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'logo': instance.logo,
      'termsConditions': instance.termsConditions,
      'currency': instance.currency?.toJson(),
      'aboutUs': instance.aboutUs,
      'faq': instance.faq,
      'communityRules': instance.communityRules,
      'isIncludeTax': instance.isIncludeTax,
      'isIncludeVat': instance.isIncludeVat,
      'otpRequestCount': instance.otpRequestCount,
      'otpLimitationMinutes': instance.otpLimitationMinutes,
      'badgeExpiredTime': instance.badgeExpiredTime,
    };
