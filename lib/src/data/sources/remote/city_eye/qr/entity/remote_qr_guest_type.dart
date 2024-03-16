import 'package:city_eye/src/domain/entities/qr/qr_guest_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_guest_type.g.dart';

@JsonSerializable()
class RemoteQrGuestType {
  final int id;
  final String code;
  final String name;

  const RemoteQrGuestType({
    this.id = 0,
    this.code = "",
    this.name = "",
  });

  factory RemoteQrGuestType.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrGuestTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrGuestTypeToJson(this);

}

extension RemoteQrGuestTypeExtension on RemoteQrGuestType {
  QrGuestType mapToDomain() {
    return QrGuestType(
      id: id ?? 0,
      code: code ?? "",
      name: name ?? "",
    );
  }
}