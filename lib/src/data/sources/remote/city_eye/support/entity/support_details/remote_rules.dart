import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_days.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/support_details/remote_sles.dart';
import 'package:city_eye/src/domain/entities/support_details/rules.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_rules.g.dart';

@JsonSerializable()
class RemoteRules {
  final bool? canRequestOnSameDay;
  final bool? execludeHoliday;
  final bool? needAssignApproval;
  final int? bufferPerDay;
  final int? bufferPerSlot;
  final int? maxDays;
  final bool? isIncludeTax;
  final bool? isIncludeVat;
  final bool? isUseCustomeConfigration;
  final bool? isDefault;
  final List<RemoteDays>? days;
  final List<RemoteSles>? slEs;

  const RemoteRules({
    this.canRequestOnSameDay = false,
    this.execludeHoliday = false,
    this.needAssignApproval = false,
    this.bufferPerDay = 0,
    this.bufferPerSlot = 0,
    this.maxDays = 0,
    this.isIncludeTax = false,
    this.isIncludeVat = false,
    this.isUseCustomeConfigration = false,
    this.isDefault = false,
    this.days = const [],
    this.slEs = const [],
  });

  factory RemoteRules.fromJson(Map<String, dynamic> json) =>
      _$RemoteRulesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteRulesToJson(this);
}

extension RemoteRulesExtension on RemoteRules {
  Rules mapToDomain() {
    return Rules(
      canRequestOnSameDay: canRequestOnSameDay ?? false,
      execludeHoliday: execludeHoliday ?? false,
      needAssignApproval: needAssignApproval ?? false,
      bufferPerDay: bufferPerDay ?? 0,
      bufferPerSlot: bufferPerSlot ?? 0,
      maxDays: maxDays ?? 0,
      isIncludeTax: isIncludeTax ?? false,
      isIncludeVat: isIncludeVat ?? false,
      isUseCustomeConfigration: isUseCustomeConfigration ?? false,
      isDefault: isDefault ?? false,
      days: (days ?? []).mapToDomain(),
      slEs: (slEs ?? []).mapToDomain(),
    );
  }
}

extension RemoteRulesListExtension on List<RemoteRules>? {
  List<Rules> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
