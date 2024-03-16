import 'package:city_eye/src/domain/entities/qr/guests_type.dart';
import 'package:city_eye/src/domain/entities/qr/qr_compound_configuration.dart';
import 'package:equatable/equatable.dart';

class QrConfiguration extends Equatable {
  final List<GuestsType> guestsTypes;
  final QrCompoundConfiguration qrCompoundConfiguration;

  const QrConfiguration({
    this.guestsTypes = const [],
    this.qrCompoundConfiguration = const QrCompoundConfiguration(),
  });

  @override
  List<Object?> get props => [
        guestsTypes,
        qrCompoundConfiguration,
      ];
}
