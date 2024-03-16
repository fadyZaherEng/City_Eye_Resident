import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_type_qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_type.dart';

final class RemoteQrType extends RemoteTypeQrHistory {
  final int? idRemoteQrType;
  final String? codeRemoteQrType;
  final String? nameRemoteQrType;

  const RemoteQrType({
    this.idRemoteQrType,
    this.codeRemoteQrType,
    this.nameRemoteQrType,
  }) : super(
          id: idRemoteQrType,
          code: codeRemoteQrType,
          name: nameRemoteQrType,
        );

  factory RemoteQrType.fromJson(Map<String, dynamic> json) {
    return RemoteQrType(
      idRemoteQrType: json['id'],
      codeRemoteQrType: json['code'],
      nameRemoteQrType: json['name'],
    );
  }

  Map<String, dynamic> toJsonRemoteQrType() {
    return {
      'id': idRemoteQrType,
      'code': codeRemoteQrType,
      'name': nameRemoteQrType,
    };
  }
}
extension RemoteQrTypeExtension on RemoteQrType {
  QrTypeQrHistory mapToDomain() => QrTypeQrHistory(
        id: id ?? 0,
        code: code ?? "",
        name: name ?? "",
      );
}