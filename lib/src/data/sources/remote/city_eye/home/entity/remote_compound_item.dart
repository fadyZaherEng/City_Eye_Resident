import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/entities/home/home_section_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_compound_item.g.dart';

@JsonSerializable()
final class RemoteHomeCompoundItem {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'isvisible')
  final bool? isVisible;

  const RemoteHomeCompoundItem({
    this.id = 0,
    this.code = "",
    this.isVisible = false,
  });

  factory RemoteHomeCompoundItem.fromJson(Map<String, dynamic> json) =>
      _$RemoteHomeCompoundItemFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteHomeCompoundItemToJson(this);
}

extension RemoteCompoundHomeSectionItemExtension on RemoteHomeCompoundItem {
  HomeCompoundItem mapToDomain() => HomeCompoundItem(
        id: id ?? 0,
        code: code ?? "",
        isVisible: isVisible ?? false,
      );
}

extension RemoteHomeCompoundItemListExtension on List<RemoteHomeCompoundItem>? {
  List<HomeCompoundItem> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
