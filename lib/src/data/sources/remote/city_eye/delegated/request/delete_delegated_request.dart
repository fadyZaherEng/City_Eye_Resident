import 'package:json_annotation/json_annotation.dart';

part 'delete_delegated_request.g.dart';

@JsonSerializable()
class DeleteDelegatedRequest {
  final int id;
  final bool isEnabled;

  const DeleteDelegatedRequest({
    required this.id,
    required this.isEnabled,
  });

  factory DeleteDelegatedRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteDelegatedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteDelegatedRequestToJson(this);

  @override
  String toString() {
    return 'DeleteDelegatedRequest{id: $id, isEnabled: $isEnabled}';
  }
}
