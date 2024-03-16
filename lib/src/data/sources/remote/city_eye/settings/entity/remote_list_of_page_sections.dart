import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_multi_media_types.dart';
import 'package:city_eye/src/domain/entities/settings/page_section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_list_of_page_sections.g.dart';

@JsonSerializable(explicitToJson: true)
class RemoteListOfPageSections {
final  int? id;
final int? pageId;
final String? pageCode;
final List<RemoteMultiMediaTypes>? multiMediaTypes;

 const RemoteListOfPageSections({
    this.id = 0,
    this.pageId = 0,
    this.pageCode = "",
    this.multiMediaTypes = const [],
  });

  factory RemoteListOfPageSections.fromJson(Map<String, dynamic> json) =>
      _$RemoteListOfPageSectionsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteListOfPageSectionsToJson(this);
}

extension RemoteListOfPageSectionsExtension on RemoteListOfPageSections? {
  PageSection get mapToDomain => PageSection(
        id: this?.id ?? 0,
        pageId: this?.pageId ?? 0,
        pageCode: this?.pageCode ?? "",
        multiMediaTypes: this!.multiMediaTypes.mapToDomain,
      );
}

extension RemoteListOfPageSectionsDataExtension
    on List<RemoteListOfPageSections>? {
  List<PageSection> get mapToDomain =>
      this!.map((pageSection) => pageSection.mapToDomain).toList();
}
