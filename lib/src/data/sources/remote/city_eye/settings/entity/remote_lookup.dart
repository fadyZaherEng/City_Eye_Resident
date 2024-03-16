import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_lookup_file.dart';
import 'package:city_eye/src/domain/entities/settings/lookup.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_lookup.g.dart';

@JsonSerializable()
class RemoteLookup {
  @JsonKey(name: 'lookupCode')
  final String? lookupCode;
  @JsonKey(name: 'lookupFiles')
  final List<RemoteLookupFile>? files;

  const RemoteLookup({
    this.lookupCode = "",
    this.files = const [],
  });

  factory RemoteLookup.fromJson(Map<String, dynamic> json) =>
      _$RemoteLookupFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteLookupToJson(this);
}


extension RemoteLookupExtension on RemoteLookup {
  Lookup mapToDomain() {
    return Lookup(
      files: files.mapToDomain(),
      lookupCode: lookupCode ?? "",
    );
  }
}

extension RemoteLookupsExtension on List<RemoteLookup>? {
  List<Lookup> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}