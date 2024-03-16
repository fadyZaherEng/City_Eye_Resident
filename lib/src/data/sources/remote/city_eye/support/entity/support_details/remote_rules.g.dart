// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_rules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteRules _$RemoteRulesFromJson(Map<String, dynamic> json) => RemoteRules(
      canRequestOnSameDay: json['canRequestOnSameDay'] as bool? ?? false,
      execludeHoliday: json['execludeHoliday'] as bool? ?? false,
      needAssignApproval: json['needAssignApproval'] as bool? ?? false,
      bufferPerDay: json['bufferPerDay'] as int? ?? 0,
      bufferPerSlot: json['bufferPerSlot'] as int? ?? 0,
      maxDays: json['maxDays'] as int? ?? 0,
      isIncludeTax: json['isIncludeTax'] as bool? ?? false,
      isIncludeVat: json['isIncludeVat'] as bool? ?? false,
      isUseCustomeConfigration:
          json['isUseCustomeConfigration'] as bool? ?? false,
      isDefault: json['isDefault'] as bool? ?? false,
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => RemoteDays.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      slEs: (json['slEs'] as List<dynamic>?)
              ?.map((e) => RemoteSles.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RemoteRulesToJson(RemoteRules instance) =>
    <String, dynamic>{
      'canRequestOnSameDay': instance.canRequestOnSameDay,
      'execludeHoliday': instance.execludeHoliday,
      'needAssignApproval': instance.needAssignApproval,
      'bufferPerDay': instance.bufferPerDay,
      'bufferPerSlot': instance.bufferPerSlot,
      'maxDays': instance.maxDays,
      'isIncludeTax': instance.isIncludeTax,
      'isIncludeVat': instance.isIncludeVat,
      'isUseCustomeConfigration': instance.isUseCustomeConfigration,
      'isDefault': instance.isDefault,
      'days': instance.days,
      'slEs': instance.slEs,
    };
