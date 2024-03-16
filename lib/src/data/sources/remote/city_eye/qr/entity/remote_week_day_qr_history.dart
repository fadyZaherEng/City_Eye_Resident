import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_type_qr_history.dart';
import 'package:city_eye/src/domain/entities/qr_history/week_day_qr_history.dart';

final class RemoteWeekDayQrHistory extends RemoteTypeQrHistory {
  final int? idRemoteWeekDayQrHistory;
  final String? codeRemoteWeekDayQrHistory;
  final String? nameRemoteWeekDayQrHistory;

  const RemoteWeekDayQrHistory({
    this.idRemoteWeekDayQrHistory,
    this.codeRemoteWeekDayQrHistory,
    this.nameRemoteWeekDayQrHistory,
  }) : super(
          id: idRemoteWeekDayQrHistory,
          code: codeRemoteWeekDayQrHistory,
          name: nameRemoteWeekDayQrHistory,
        );

  factory RemoteWeekDayQrHistory.fromJson(Map<String, dynamic> json) {
    return RemoteWeekDayQrHistory(
      idRemoteWeekDayQrHistory: json['id'],
      codeRemoteWeekDayQrHistory: json['code'],
      nameRemoteWeekDayQrHistory: json['name'],
    );
  }

  Map<String, dynamic> toJsonRemoteWeekDayQrHistory() {
    return {
      'id': idRemoteWeekDayQrHistory,
      'code': codeRemoteWeekDayQrHistory,
      'name': nameRemoteWeekDayQrHistory,
    };
  }
}
extension RemoteWeekDayQrHistoryExtension on RemoteWeekDayQrHistory {
  WeekDayQrHistory mapToDomain() {
    return WeekDayQrHistory(
      id: id ?? 0,
      code: code ?? "",
      name: name ?? "",
    );
  }
}