
import 'package:city_eye/src/domain/entities/complain/complain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_complain.g.dart';

@JsonSerializable()
class RemoteComplain {
  final int? id;

  const RemoteComplain({
    this.id = 0,
  });

  factory RemoteComplain.fromJson(Map<String, dynamic> json) => _$RemoteComplainFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteComplainToJson(this);
}

extension RemoteComplainExtension on RemoteComplain {
  Complain mapToDomain() {
    return Complain(
      id: id ?? 0,
    );
  }
}
