import 'package:json_annotation/json_annotation.dart';

part 'deactivate_qr_request.g.dart';

@JsonSerializable()
final class DeactivateQrRequest {
  @JsonKey(name: 'qrId')
  final int id;
  final bool isEnabled;

  const DeactivateQrRequest({
    required this.id,
    required this.isEnabled,
  });

  factory DeactivateQrRequest.fromJson(Map<String, dynamic> json) =>
      _$DeactivateQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeactivateQrRequestToJson(this);

  @override
  String toString() {
    return 'DeactivateQrRequest{id: $id , isEnabled: $isEnabled}';
  }
}
