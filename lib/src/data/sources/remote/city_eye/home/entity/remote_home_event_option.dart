import 'package:city_eye/src/domain/entities/home/home_event_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_home_event_option.g.dart';

@JsonSerializable()
class RemoteHomeEventOption {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'eventId')
  final int? eventId;
  @JsonKey(name: 'isCalendar')
  final bool? isCalendar;
  @JsonKey(name: 'isJoin')
  final bool? isJoin;
  @JsonKey(name: 'isSelectedByUser')
  final bool? isSelectedByUser;

  const RemoteHomeEventOption({
    this.id = 0,
    this.name = "",
    this.eventId = 0,
    this.isCalendar = false,
    this.isJoin = false,
    this.isSelectedByUser = false,
  });

  factory RemoteHomeEventOption.fromJson(Map<String, dynamic> json) =>
      _$RemoteHomeEventOptionFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHomeEventOptionToJson(this);

}

extension RemoteHomeEventOptionExtension on RemoteHomeEventOption {
  HomeEventOption mapToDomain() => HomeEventOption(
    id: id ?? 0,
    name: name ?? "",
    eventId: eventId ?? 0,
    isCalendar: isCalendar ?? false,
    isJoin: isJoin ?? false,
    isSelectedByUser: isSelectedByUser ?? false,
  );
}

extension RemoteHomeEventOptionListExtension on List<RemoteHomeEventOption>? {
  List<HomeEventOption> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}