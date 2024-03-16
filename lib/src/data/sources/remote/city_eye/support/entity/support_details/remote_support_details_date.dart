import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_compound_configration.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_support_category.dart';
import 'package:city_eye/src/domain/entities/support_details/support_details_date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_support_details_date.g.dart';

@JsonSerializable()
class RemoteSupportDetailsDate {
  final RemoteSupportCategory? supportCategory;
  final RemoteCompoundConfiguration? compoundConfigration;

  const RemoteSupportDetailsDate({
    this.supportCategory = const RemoteSupportCategory(),
    this.compoundConfigration = const RemoteCompoundConfiguration(),
  });

  factory RemoteSupportDetailsDate.fromJson(Map<String, dynamic> json) =>
      _$RemoteSupportDetailsDateFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSupportDetailsDateToJson(this);
}

extension SupportDetailsDateExtension on RemoteSupportDetailsDate {
  SupportDetailsDate mapToDomain() {
    return SupportDetailsDate(
      supportCategory:
          (supportCategory ?? const RemoteSupportCategory()).mapToDomain(),
      compoundConfigration:
          (compoundConfigration ?? const RemoteCompoundConfiguration())
              .mapToDomain(),
    );
  }
}
