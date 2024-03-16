import 'package:json_annotation/json_annotation.dart';
part 'qr_history_request.g.dart';

@JsonSerializable()
final class QrHistoryRequest {
  final bool isStatus;

  const QrHistoryRequest({
    required this.isStatus,
  });

  factory QrHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$QrHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QrHistoryRequestToJson(this);

  @override
  String toString() {
    return 'QrHistoryRequest{isStatus: $isStatus}';
  }
}
