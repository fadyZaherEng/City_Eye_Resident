import 'package:equatable/equatable.dart';

class UserUnitParent extends Equatable {
  final int id;
  final String name;
  final int sortNumber;

  const UserUnitParent({
    this.id = 0,
    this.name = "",
    this.sortNumber = 0,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sortNumber': sortNumber,
    };
  }

  factory UserUnitParent.fromMap(Map<String, dynamic> map) {
    return UserUnitParent(
      id: map['id'] as int,
      name: map['name'] as String,
      sortNumber: map['sortNumber'] as int,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    sortNumber,
  ];


}
