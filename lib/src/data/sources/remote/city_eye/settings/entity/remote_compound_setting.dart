import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_currency.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_compound_type.dart';
import 'package:city_eye/src/domain/entities/settings/compound_setting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_setting.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteCompoundSetting {
  final int? id;
  final String? name;
  final RemoteCompoundType? compoundType;
  final String? owner;
  final String? mobile;
  final String? email;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? logo;
  final String? termsConditions;
  final RemoteCompoundCurrency? currency;
  final String? aboutUs;
  final String? faq;
  final String? communityRules;
  final bool? isIncludeTax;
  final bool? isIncludeVat;
  final int? otpRequestCount;
  final int? otpLimitationMinutes;
  final int? badgeExpiredTime;

  const RemoteCompoundSetting({
    this.id = 0,
    this.name = "",
    this.compoundType = const RemoteCompoundType(),
    this.owner = "",
    this.mobile = "",
    this.email = "",
    this.latitude = "",
    this.longitude = "",
    this.address = "",
    this.logo = "",
    this.termsConditions = "",
    this.currency = const RemoteCompoundCurrency(),
    this.aboutUs = "",
    this.faq = "",
    this.communityRules = "",
    this.isIncludeTax = false,
    this.isIncludeVat = false,
    this.otpRequestCount = 0,
    this.otpLimitationMinutes = 0,
    this.badgeExpiredTime = 0,
  });

  factory RemoteCompoundSetting.fromJson(Map<String, dynamic> json) =>
      _$RemoteCompoundSettingFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCompoundSettingToJson(this);
}

extension RemoteCompoundSettingExtension on RemoteCompoundSetting? {
  CompoundSetting get mapToDomain => CompoundSetting(
        id: this?.id ?? 0,
        logo: this?.logo ?? "",
        name: this?.name ?? "",
        mobile: this?.mobile ?? "",
        email: this?.email ?? "",
        aboutUs: this?.aboutUs ?? "",
        address: this?.address ?? "",
        compoundType: this!.compoundType.mapToDomain,
        currency: this!.currency.mapToDomain,
        latitude: this?.latitude ?? "",
        longitude: this?.longitude ?? "",
        owner: this?.owner ?? "",
        termsConditions: this?.termsConditions ?? "",
        communityRules: this?.communityRules ?? "",
        faq: this?.faq ?? "",
        isIncludeTax: this?.isIncludeTax ?? false,
        isIncludeVat: this?.isIncludeVat ?? false,
        otpLimitationMinutes: this?.otpLimitationMinutes ?? 0,
        otpRequestCount: this?.otpRequestCount ?? 0,
        badgeExpiredTime: this?.badgeExpiredTime ?? 0,
      );
}
