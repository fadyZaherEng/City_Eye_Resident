import 'package:equatable/equatable.dart';

class FamilyMemberType extends Equatable {
  final int id;
  final String name;
  final bool isSelected;

  const FamilyMemberType({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  FamilyMemberType copyWith({
    bool? isSelected,
  }) {
    return FamilyMemberType(
      id: id,
      name: name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, isSelected];
}
