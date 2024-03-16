import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_type_qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/status.dart';

final class RemoteStatusQrHistory extends RemoteTypeQrHistory {
  final int? idRemoteStatusQrHistory;
  final String? codeRemoteStatusQrHistory;
  final String? nameRemoteStatusQrHistory;
  final String? color;

  const RemoteStatusQrHistory({
    this.idRemoteStatusQrHistory,
    this.codeRemoteStatusQrHistory,
    this.nameRemoteStatusQrHistory,
    this.color = "",
  }) : super(
          id: idRemoteStatusQrHistory,
          code: codeRemoteStatusQrHistory,
          name: nameRemoteStatusQrHistory,
        );

  factory RemoteStatusQrHistory.fromJson(Map<String, dynamic> json) {
    return RemoteStatusQrHistory(
      idRemoteStatusQrHistory: json['id'],
      codeRemoteStatusQrHistory: json['code'],
      nameRemoteStatusQrHistory: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJsonRemoteStatusQrHistory() {
    return {
      'id': idRemoteStatusQrHistory,
      'code': codeRemoteStatusQrHistory,
      'name': nameRemoteStatusQrHistory,
      'color': color,
    };
  }
}

extension RemoteStatusQrHistoryExtension on RemoteStatusQrHistory {
  StatusQrHistory mapToDomain() {
    return StatusQrHistory(
      id: id ?? 0,
      code: code ?? "",
      name: name ?? "",
      color: color ?? "",
    );
  }
}
