import 'package:city_eye/src/domain/entities/delegated/submit_delegation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_submit_delegation.g.dart';

@JsonSerializable()
class RemoteSubmitDelegation{
  final String? link;
  final String? qrImage;
  final int? pinCode;

  const RemoteSubmitDelegation({
    this.link = "",
    this.qrImage = "",
    this.pinCode = 0,
  });

  factory RemoteSubmitDelegation.fromJson(Map<String, dynamic> json) => _$RemoteSubmitDelegationFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSubmitDelegationToJson(this);

}

extension RemoteSubmitDelegationExtension on RemoteSubmitDelegation {
  SubmitDelegation mapToDomain() {
    return SubmitDelegation(
      link: link ?? "",
      qrImage: qrImage ?? "",
      pinCode: pinCode ?? 0,
    );
  }
}