import 'package:city_eye/src/domain/entities/qr/qr_guest_type.dart';
import 'package:equatable/equatable.dart';

class QrRule extends Equatable {
  final int id;
  final int qrCodeConfigrationId;
  final QrGuestType guestType;
  final String rules;

  const QrRule({
    this.id = 0,
    this.qrCodeConfigrationId = 0,
    this.guestType = const QrGuestType(),
    this.rules = "",
  });

  @override
  List<Object?> get props => [id, qrCodeConfigrationId, guestType, rules];
}
