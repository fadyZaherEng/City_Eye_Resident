import 'package:json_annotation/json_annotation.dart';

part 'wall_details_request.g.dart';

@JsonSerializable()
class WallDetailsRequest {
  @JsonKey(name: 'id')
  final String id;

  const WallDetailsRequest({
    required this.id,
  });

  factory WallDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$WallDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WallDetailsRequestToJson(this);
}