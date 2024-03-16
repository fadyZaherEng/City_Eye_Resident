import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_page_field.dart';
import 'package:city_eye/src/domain/entities/settings/page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_page.g.dart';

@JsonSerializable()
class RemotePage {
  @JsonKey(name: 'pageCode')
  final String? pageCode;
  @JsonKey(name: 'extraFieldDtos')
  final List<RemotePageField>? fields;

  const RemotePage({
    this.pageCode = "",
    this.fields = const [],
  });

  factory RemotePage.fromJson(Map<String, dynamic> json) =>
      _$RemotePageFromJson(json);

  Map<String, dynamic> toJson() => _$RemotePageToJson(this);
}

extension RemotePageExtension on RemotePage {
  Page mapToDomain() {
    return Page(
      code: pageCode ?? "",
      fields: fields?.map((e) => e.mapToDomain()).toList() ?? [],
    );
  }
}

extension RemotePagesExtension on List<RemotePage>? {
  List<Page> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
