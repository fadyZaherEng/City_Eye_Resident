import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_event.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_extra_field.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/event/event_details_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_event_details_data.g.dart';

@JsonSerializable()
final class RemoteEventDetailsData {
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'events')
  final RemoteEvent? events;
  @JsonKey(name: 'extraFieldEvents')
  final List<RemoteExtraField>? extraFieldEvents;

  RemoteEventDetailsData({
    this.link = "",
    this.events = const RemoteEvent(),
    this.extraFieldEvents = const [],
  });

  factory RemoteEventDetailsData.fromJson(Map<String, dynamic> json) =>
      _$RemoteEventDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEventDetailsDataToJson(this);
}

extension RemoteEventDetailsDataExtension on RemoteEventDetailsData {
  EventDetailsData get mapToDomain => EventDetailsData(
        event: (events ?? const RemoteEvent()).mapToDomain,
        dynamicQuestions: (extraFieldEvents ?? []).mapToDomain,
    link: link ?? "",
      );
}
