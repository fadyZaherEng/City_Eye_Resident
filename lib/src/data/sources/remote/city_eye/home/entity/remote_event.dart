import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_event_rules.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_events_attachments.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_home_event_option.dart';
import 'package:city_eye/src/domain/entities/home/home_event_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_event.g.dart';

@JsonSerializable()
final class RemoteEvent {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'openingDate')
  final String? openingDate;
  @JsonKey(name: 'closedDate')
  final String? closedDate;
  @JsonKey(name: 'isPaid')
  final bool? isPaid;
  @JsonKey(name: 'memberCount')
  final int? memberCount;
  @JsonKey(name: 'maxCountJoin')
  final int? maxCountJoin;
  @JsonKey(name: 'memberPrice')
  final int? memberPrice;
  @JsonKey(name: 'locationAddress')
  final String? locationAddress;
  @JsonKey(name: 'locationLatitude')
  final String? locationLatitude;
  @JsonKey(name: 'locationLongitude')
  final String? locationLongitude;
  @JsonKey(name: 'transactionId')
  final int? transactionId;
  @JsonKey(name: 'calenderRef')
  final String? calenderRef;
  @JsonKey(name: 'eventsOptions')
  final List<RemoteHomeEventOption>? eventsOptions;
  @JsonKey(name: 'eventsRules')
  final List<RemoteEventRules>? eventsRules;
  @JsonKey(name: 'eventsAttachments')
  final List<RemoteEventAttachments>? eventsAttachments;

  const RemoteEvent({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.startDate = "",
    this.endDate = "",
    this.openingDate = "",
    this.closedDate = "",
    this.isPaid = false,
    this.maxCountJoin = 0,
    this.memberCount = 0,
    this.memberPrice = 0,
    this.locationAddress = "",
    this.locationLatitude = "",
    this.locationLongitude = "",
    this.transactionId = 0,
    this.calenderRef = "",
    this.eventsOptions = const [],
    this.eventsRules = const [],
    this.eventsAttachments = const [],
  });

  factory RemoteEvent.fromJson(Map<String, dynamic> json) =>
      _$RemoteEventFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteEventToJson(this);
}

extension RemoteEventExtension on RemoteEvent {
  HomeEventItem get mapToDomain => HomeEventItem(
        id: id ?? 0,
        title: title ?? "",
        description: description ?? "",
        startDate: startDate ?? "",
        endDate: endDate ?? "",
        openingDate: openingDate ?? "",
        closedDate: closedDate ?? "",
        isPaid: isPaid ?? false,
        maxCountJoin: maxCountJoin ?? 0,
        memberCount: memberCount ?? 0,
        memberPrice: memberPrice ?? 0,
        locationAddress: locationAddress ?? "",
        locationLatitude: locationLatitude ?? "",
        locationLongitude: locationLongitude ?? "",
        transactionId: transactionId ?? 0,
        calenderRef: calenderRef ?? "",
        eventsOptions: (eventsOptions ?? []).mapToDomain(),
        eventsRules: (eventsRules ?? []).mapToDomain(),
        eventsAttachments: (eventsAttachments ?? []).mapToDomain(),
      );
}

extension RemoteEventListExtension on List<RemoteEvent>? {
  List<HomeEventItem> get mapToDomain =>
      this!.map((event) => event.mapToDomain).toList();
}
