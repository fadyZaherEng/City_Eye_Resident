import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:equatable/equatable.dart';

class CityCompound extends Equatable {
  final int id;
  final int parentId;
  final String name;
  final List<Compound> compounds;

  const CityCompound({
    this.id = 0,
    this.parentId = 0,
    this.name = "",
    this.compounds = const [],
  });


  CityCompound copyWith({
    int? id,
    int? parentId,
    String? name,
    List<Compound>? compounds,
  }) {
    return CityCompound(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      compounds: compounds ?? this.compounds,
    );
  }
  @override
  List<Object?> get props => [
        id,
        name,
        parentId,
        compounds,
      ];
}
