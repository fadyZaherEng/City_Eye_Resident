import 'package:city_eye/src/domain/entities/qr_history/guest_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/qr_type.dart';
import 'package:city_eye/src/domain/entities/qr_history/status.dart';
import 'package:city_eye/src/domain/entities/qr_history/unit_qr_code_day.dart';
import 'package:equatable/equatable.dart';

class QrHistory extends Equatable {
  final int id;
  final String name;
  final GuestTypeQrHistory guestType;
  final StatusQrHistory status;
  final QrTypeQrHistory qrType;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;
  final String createdDateStatus;
  final bool isEnabled;
  final List<UnitsQrCodeDay> unitsQrCodeDays;
  final int pinCode;
  final String address;

  const QrHistory({
    this.id = 0,
    this.name = "",
    this.guestType = const GuestTypeQrHistory(),
    this.status = const StatusQrHistory(),
    this.qrType = const QrTypeQrHistory(),
    this.fromDate = "",
    this.toDate = "",
    this.fromTime = "",
    this.toTime = "",
    this.createdDateStatus = "",
    this.isEnabled = false,
    this.unitsQrCodeDays = const [],
    this.pinCode = 0,
    this.address = "",
  });

  QrHistory copyWith({
    int? id,
    String? name,
    GuestTypeQrHistory? guestType,
    StatusQrHistory? status,
    QrTypeQrHistory? qrType,
    String? fromDate,
    String? toDate,
    String? fromTime,
    String? toTime,
    bool? isEnabled,
    String? createdDateStatus,
    List<UnitsQrCodeDay>? unitsQrCodeDays,
    int? pinCode,
    String? address,
  }) =>
      QrHistory(
        id: id ?? this.id,
        name: name ?? this.name,
        guestType: guestType ?? this.guestType,
        status: status ?? this.status,
        qrType: qrType ?? this.qrType,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        fromTime: fromTime ?? this.fromTime,
        toTime: toTime ?? this.toTime,
        createdDateStatus: createdDateStatus ?? this.createdDateStatus,
        isEnabled: isEnabled ?? this.isEnabled,
        unitsQrCodeDays: unitsQrCodeDays ?? this.unitsQrCodeDays,
        pinCode: pinCode ?? this.pinCode,
        address: address ?? this.address,
      );

  @override
  List<Object> get props => [
        id,
        name,
        guestType,
        status,
        qrType,
        fromDate,
        toDate,
        fromTime,
        toTime,
        createdDateStatus,
        isEnabled,
        unitsQrCodeDays,
        pinCode,
        address,
      ];
}
