import 'package:json_annotation/json_annotation.dart';
part 'remote_type_qr_history.g.dart';

@JsonSerializable()
class RemoteTypeQrHistory {
  final int? id;
  final String? code;
  final String? name;

  const RemoteTypeQrHistory({
    this.id = 0,
    this.code = "",
    this.name = "",
  });

  factory RemoteTypeQrHistory.fromJson(Map<String, dynamic> json) =>
      _$RemoteTypeQrHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTypeQrHistoryToJson(this);
}
