import 'package:json_annotation/json_annotation.dart';

part 'delete_request.g.dart';

@JsonSerializable()
class DeleteRequest {
  @JsonKey(name: 'id')
  final String id;

  const DeleteRequest({
    required this.id,
  });

  factory DeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteRequestToJson(this);
}
