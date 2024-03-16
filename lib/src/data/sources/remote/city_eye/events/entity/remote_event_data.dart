import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_event.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_extra_field.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_event_data.g.dart';

@JsonSerializable()
final class RemoteEventData {
  @JsonKey(name: 'events')
  final List<RemoteEvent>? events;
  @JsonKey(name: 'extraFieldEvents')
  final List<RemoteExtraField>? extraFieldEvents;

  RemoteEventData({
    this.events = const [],
    this.extraFieldEvents = const [],
  });

  factory RemoteEventData.fromJson(Map<String, dynamic> json) => _$RemoteEventDataFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEventDataToJson(this);
}

extension RemoteEventDataExtension on RemoteEventData {
  EventData get mapToDomain => EventData(
    events: (events ?? []).mapToDomain,
    dynamicQuestions: (extraFieldEvents ?? []).mapToDomain,
  );
}