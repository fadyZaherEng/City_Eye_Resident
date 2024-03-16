import 'package:json_annotation/json_annotation.dart';

part 'qr_details_request.g.dart';

@JsonSerializable()
final class QrDetailsRequest {
  @JsonKey(name:'qrId')
  final int id;

  const QrDetailsRequest({required this.id});

  factory QrDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$QrDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QrDetailsRequestToJson(this);

  @override
  String toString() {
    return 'QrDetailsRequest{id: $id}';
  }
}
