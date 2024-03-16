import 'package:city_eye/src/domain/entities/home/event_rules.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_event_rules.g.dart';

@JsonSerializable()
class RemoteEventRules {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'eventId')
  final int? eventId;

  const RemoteEventRules({
    this.id = 0,
    this.description = "",
    this.eventId = 0,
  });

  factory RemoteEventRules.fromJson(Map<String, dynamic> json) =>
      _$RemoteEventRulesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEventRulesToJson(this);

}

extension RemoteEventRulesExtension on RemoteEventRules {
  EventRules mapToDomain() {
    return EventRules(
      id: id ?? 0,
      description: description ?? "",
      eventId: eventId ?? 0
    );
  }
}

extension RemoteEventRulesListExtension on List<RemoteEventRules> {
  List<EventRules> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}