import 'package:city_eye/src/data/sources/remote/city_eye/qr/entity/remote_qr_guest_type.dart';
import 'package:city_eye/src/domain/entities/qr/qr_rule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_qr_rule.g.dart';

@JsonSerializable()
class RemoteQrRule{
  final int id;
  final int qrCodeConfigrationId;
  final RemoteQrGuestType? guestType;
  final String rules;

  RemoteQrRule({
    this.id = 0,
    this.qrCodeConfigrationId = 0,
    this.guestType = const RemoteQrGuestType(),
    this.rules = "",
  });

  factory RemoteQrRule.fromJson(Map<String, dynamic> json) => _$RemoteQrRuleFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteQrRuleToJson(this);
}

extension RemoteQrRuleExtension on RemoteQrRule {
  QrRule mapToDomain() {
    return QrRule(
      id: id ?? 0,
      qrCodeConfigrationId: qrCodeConfigrationId ?? 0,
      guestType: (guestType?? const RemoteQrGuestType()).mapToDomain(),
      rules: rules ?? "",
    );
  }
}

extension RemoteQrRuleListExtension on List<RemoteQrRule> {
  List<QrRule> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}