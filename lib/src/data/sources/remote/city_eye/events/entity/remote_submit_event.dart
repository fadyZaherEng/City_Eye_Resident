import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_extra_field.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';
import 'package:json_annotation/json_annotation.dart';
part 'remote_submit_event.g.dart';

@JsonSerializable()
final class RemoteSubmitEvent {
  @JsonKey(name: 'transactionId')
  final int? transactionId;
  @JsonKey(name: 'countCurrentJoin')
  final int? countCurrentJoin;
  @JsonKey(name: 'extraFieldEvents')
  final List<RemoteExtraField>? extraFieldEvents;

  RemoteSubmitEvent({
    this.transactionId = 0,
    this.countCurrentJoin = 0,
    this.extraFieldEvents = const [],
  });

  factory RemoteSubmitEvent.fromJson(Map<String, dynamic> json) =>
      _$RemoteSubmitEventFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSubmitEventToJson(this);
}

extension RemoteSubmitEventExtension on RemoteSubmitEvent {
  SubmitEvent mapToDomain() {
    return SubmitEvent(
      transactionId: transactionId ?? 0,
      countCurrentJoin: countCurrentJoin ?? 0,
      fields: (extraFieldEvents ?? []).mapToDomain,
    );
  }
}
