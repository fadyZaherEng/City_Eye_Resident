import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_guests_type.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_compound_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qr_compound_configuration.dart';
import 'package:city_eye/src/domain/entities/qr/qr_configuration.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_configuration.g.dart';

@JsonSerializable()
class RemoteQrConfiguration {
  @JsonKey(name: 'qrMessage')
  final String? qrMessage;
  @JsonKey(name: 'guestTypes')
  final List<RemoteGuestsType>? guestTypes;
  @JsonKey(name: 'compoundConfigration')
  final RemoteQrCompoundConfiguration? qrCompoundConfiguration;

  const RemoteQrConfiguration({
    this.qrMessage = "",
    this.guestTypes = const [],
    this.qrCompoundConfiguration = const RemoteQrCompoundConfiguration(),
  });

  factory RemoteQrConfiguration.fromJson(Map<String, dynamic> json) =>
      _$RemoteQrConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrConfigurationToJson(this);
}

extension RemoteQrConfigurationExtension on RemoteQrConfiguration? {
  QrConfiguration mapToDomain() {
    return QrConfiguration(
      guestsTypes: this?.guestTypes?.map((e) => e.mapToDomain()).toList() ?? [],
      qrCompoundConfiguration: this?.qrCompoundConfiguration?.mapToDomain() ??
          const QrCompoundConfiguration(),
    );
  }
}
