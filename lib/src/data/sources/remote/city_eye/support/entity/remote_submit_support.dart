import 'package:city_eye/src/domain/entities/support_details/submit_support.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_submit_support.g.dart';

@JsonSerializable()
final class RemoteSubmitSupport {
  final int id;

  const RemoteSubmitSupport({
    this.id = 0,
  });

  factory RemoteSubmitSupport.fromJson(Map<String, dynamic> json) =>
      _$RemoteSubmitSupportFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSubmitSupportToJson(this);
}

extension RemoteSubmitSupportExtension on RemoteSubmitSupport? {
  SubmitSupport mapToDomain() {
    return SubmitSupport(
      id: this?.id ?? 0,
    );
  }
}
