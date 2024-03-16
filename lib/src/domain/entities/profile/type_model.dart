import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:equatable/equatable.dart';

class TypeModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final bool isSelected;

  const TypeModel({
    this.id = -1,
    this.name = "",
    this.code = "",
    this.isSelected = false,
  });

  copyWith({
    int? id,
    String? name,
    String? code,
    bool? isSelected,
  }) {
    return TypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      isSelected: isSelected ?? this.isSelected
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        name,
      ];
}

extension TypeModelExtension on TypeModel {
  LookupFile toLookupFile() {
    return LookupFile(
      id: id,
      name: name,
      code: code,
    );
  }
}
extension LookupFileToTypeModelExtension on LookupFile {
  TypeModel toTypeModel() {
    return TypeModel(
      id: id,
      name: name,
      code: code,
    );
  }
}