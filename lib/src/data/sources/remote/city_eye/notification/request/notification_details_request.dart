import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_details_request.g.dart';

@JsonSerializable()
final class NotificationDetailsRequest extends Equatable {
  final int id;

  const NotificationDetailsRequest({
    required this.id,
  });

  factory NotificationDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDetailsRequestToJson(this);

  @override
  List<Object> get props => [id];
}
