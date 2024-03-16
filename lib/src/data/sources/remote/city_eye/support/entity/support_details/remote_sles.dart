import 'package:city_eye/src/domain/entities/support_details/sles.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_sles.g.dart';

@JsonSerializable()
class RemoteSles {
  final int? id;
  final String? name;
  final String? code;
  final int? noOfMinutes;
  final bool? isSLE;

  const RemoteSles({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.noOfMinutes = 0,
    this.isSLE = false,
  });

  factory RemoteSles.fromJson(Map<String, dynamic> json) =>
      _$RemoteSlesFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSlesToJson(this);
}

extension RemoteSllsExtension on RemoteSles {
  Sles mapToDomain() {
    return Sles(
      id: id ?? 0,
      name: name ?? "",
      code: code ?? "",
      noOfMinutes: noOfMinutes ?? 0,
      isSLE: isSLE ?? false,
    );
  }
}

extension RemoteSllsListExtension on List<RemoteSles>? {
  List<Sles> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}