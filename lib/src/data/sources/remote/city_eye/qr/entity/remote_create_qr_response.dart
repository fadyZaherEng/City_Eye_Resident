import 'package:city_eye/src/domain/entities/qr/create_qr_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_create_qr_response.g.dart';

@JsonSerializable()
class RemoteCreateQrResponse {
  final int? qrId;
  final String? qrImage;
  final String? qrPdf;

  const RemoteCreateQrResponse({
    this.qrId = 0,
    this.qrImage = "",
    this.qrPdf = "",
  });

  factory RemoteCreateQrResponse.fromJson(Map<String, dynamic> json) => _$RemoteCreateQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteCreateQrResponseToJson(this);
}

extension CreateQrResponseExtension on RemoteCreateQrResponse {
  CreateQrResponse mapToDomain() {
    return CreateQrResponse(
      qrId: qrId ?? 0,
      qrImage: qrImage ?? "",
      qrPdf: qrPdf ?? "",
    );
  }
}
