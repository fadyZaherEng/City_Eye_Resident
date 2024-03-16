import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_type_qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/guest_type.dart';

final class RemoteGuestType extends RemoteTypeQrHistory {
  final int? idRemoteGuestType;
  final String? codeRemoteGuestType;
  final String? nameRemoteGuestType;

  const RemoteGuestType({
    this.idRemoteGuestType,
    this.codeRemoteGuestType,
    this.nameRemoteGuestType,
  }) : super(
          id: idRemoteGuestType,
          code: codeRemoteGuestType,
          name: nameRemoteGuestType,
        );

  factory RemoteGuestType.fromJson(Map<String, dynamic> json) {
    return RemoteGuestType(
      idRemoteGuestType: json['id'],
      codeRemoteGuestType: json['code'],
      nameRemoteGuestType: json['name'],
    );
  }

  Map<String, dynamic> toJsonRemoteGuestType() {
    return {
      'id': idRemoteGuestType,
      'code': codeRemoteGuestType,
      'name': nameRemoteGuestType,
    };
  }
}

extension RemoteGuestTypeExtension on RemoteGuestType {
  GuestTypeQrHistory mapToDomain() {
    return GuestTypeQrHistory(
      id: id ?? 0,
      code: code ?? "",
      name: name ?? "",
    );
  }
}
