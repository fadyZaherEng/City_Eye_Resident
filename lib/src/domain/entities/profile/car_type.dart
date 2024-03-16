import 'package:equatable/equatable.dart';

class CarType extends Equatable {
  final int id;
  final String name;
  final int parentId;
  final bool isSelected;

  const CarType({
    this.id = -1,
    this.name = "",
    this.parentId = -1,
    this.isSelected = false,
  });

  CarType copyWith({
    int? id,
    String? name,
    int? parentId,
    bool? isSelected,
  }) {
    return CarType(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        parentId,
        isSelected,
      ];
}
