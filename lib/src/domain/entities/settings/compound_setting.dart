import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:city_eye/src/domain/entities/settings/compound_type.dart';
import 'package:equatable/equatable.dart';

final class CompoundSetting extends Equatable {
  final int id;
  final String name;
  final CompoundType compoundType;
  final String owner;
  final String mobile;
  final String email;
  final String latitude;
  final String longitude;
  final String address;
  final String logo;
  final String termsConditions;
  final String faq;
  final CompoundCurrency currency;
  final String aboutUs;
  final String communityRules;
  final bool isIncludeTax;
  final bool isIncludeVat;
  final int otpRequestCount;
  final int otpLimitationMinutes;
  final int badgeExpiredTime;

  const CompoundSetting({
    this.id = 0,
    this.name = "",
    this.compoundType = const CompoundType(),
    this.owner = "",
    this.mobile = "",
    this.email = "",
    this.latitude = "",
    this.longitude = "",
    this.address = "",
    this.logo = "",
    this.termsConditions = "",
    this.currency = const CompoundCurrency(),
    this.aboutUs = "",
    this.faq = "",
    this.communityRules = "",
    this.isIncludeTax = false,
    this.isIncludeVat = false,
    this.otpRequestCount = 0,
    this.otpLimitationMinutes = 0,
    this.badgeExpiredTime = 0,
  });

  @override
  List<Object> get props => [
        id,
        name,
        compoundType,
        owner,
        mobile,
        email,
        latitude,
        longitude,
        address,
        logo,
        termsConditions,
        currency,
        aboutUs,
        faq,
        communityRules,
        isIncludeTax,
        isIncludeVat,
        otpRequestCount,
        otpLimitationMinutes,
        badgeExpiredTime,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'compoundType': compoundType.toMap(),
      'owner': owner,
      'mobile': mobile,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'logo': logo,
      'termsConditions': termsConditions,
      'currency': currency.toMap(),
      'aboutUs': aboutUs,
      'fag': faq,
      'communityRules': communityRules,
      'isIncludeTax': isIncludeTax,
      'isIncludeVat': isIncludeVat,
      'otpRequestCount': otpRequestCount,
      'otpLimitationMinutes': otpLimitationMinutes,
      'badgeExpiredTime': badgeExpiredTime,
    };
  }

  factory CompoundSetting.fromMap(Map<String, dynamic> map) {
    return CompoundSetting(
      id: map['id'] as int,
      name: map['name'] as String,
      compoundType: CompoundType.fromMap(map['compoundType']),
      owner: map['owner'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      address: map['address'] as String,
      logo: map['logo'] as String,
      termsConditions: map['termsConditions'] as String,
      currency: CompoundCurrency.fromMap(map['currency']),
      aboutUs: map['aboutUs'] as String,
      faq: map['fag'] as String,
      communityRules: map['communityRules'] as String,
      isIncludeTax: map['isIncludeTax'] as bool,
      isIncludeVat: map['isIncludeVat'] as bool,
      otpRequestCount: map['otpRequestCount'] as int,
      otpLimitationMinutes: map['otpLimitationMinutes'] as int,
      badgeExpiredTime: map['badgeExpiredTime'] as int,
    );
  }
}
