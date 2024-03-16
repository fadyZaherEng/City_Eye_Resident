import 'package:city_eye/src/domain/entities/settings/multi_media_types.dart';
import 'package:equatable/equatable.dart';

final class PageSection extends Equatable {
  final int id;
  final int pageId;
  final String pageCode;
  final List<MultiMediaTypes> multiMediaTypes;

  const PageSection({
    this.id = 0,
    this.pageId = 0,
    this.pageCode = "",
    this.multiMediaTypes = const [],
  });

  @override
  List<Object> get props => [
        id,
        pageId,
        pageCode,
        multiMediaTypes,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pageId': pageId,
      'pageCode': pageCode,
      'multiMediaTypes': multiMediaTypes.map((element) => element.toMap()).toList()
    };
  }

  factory PageSection.fromMap(Map<String, dynamic> map) {
    return PageSection(
      id: map['id'] as int,
      pageId: map['pageId'] as int,
      pageCode: map['pageCode'] as String,
      multiMediaTypes:  List<MultiMediaTypes>.from(map['multiMediaTypes']?.map((x) => MultiMediaTypes.fromMap(x))),
    );
  }
}
