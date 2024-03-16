import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_guest_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_status_qr_history.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_unit_qr_code_day.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_history.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteQrHistory {
  final int? id;
  final String? name;
  final RemoteGuestType? guestType;
  final RemoteStatusQrHistory? status;
  final RemoteQrType? qrType;
  final String? fromDate;
  final String? toDate;
  final String? fromTime;
  final String? toTime;
  final String? createdDateStatus;
  final bool? isEnabled;
  final List<RemoteUnitsQrCodeDay>? unitsQRCodeDays;
  final int? pinCode;
  final String? address;

  const RemoteQrHistory({
    this.id = 0,
    this.name = "",
    this.guestType = const RemoteGuestType(),
    this.status = const RemoteStatusQrHistory(),
    this.qrType = const RemoteQrType(),
    this.fromDate = "",
    this.toDate = "",
    this.fromTime = "",
    this.toTime = "",
    this.createdDateStatus = "",
    this.isEnabled = false,
    this.unitsQRCodeDays = const [],
    this.pinCode = 0,
    this.address = "",
  });

  factory RemoteQrHistory.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrHistoryToJson(this);
}

extension RemoteQrHistoryExtension on RemoteQrHistory {
  QrHistory mapToDomain() => QrHistory(
        id: id ?? 0,
        name: name ?? "",
        guestType: guestType!.mapToDomain(),
        status: status!.mapToDomain(),
        qrType: qrType!.mapToDomain(),
        fromDate: fromDate ?? "",
        toDate: toDate ?? "",
        fromTime: fromTime ?? "",
        toTime: toTime ?? "",
        createdDateStatus: createdDateStatus ?? "",
        isEnabled: isEnabled ?? false,
        unitsQrCodeDays: unitsQRCodeDays.mapToDomain(),
        pinCode: pinCode ?? 0,
        address: address ?? "",
      );
}

extension RemoteQrHistoryListExtension on List<RemoteQrHistory>? {
  List<QrHistory> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
