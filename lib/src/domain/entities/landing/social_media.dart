import 'package:equatable/equatable.dart';

class SocialMedia extends Equatable {
  final int id;
  final String name;
  final String code;
  final String logo;
  final String extraValueOne;
  final String extraValueTwo;
  final int parentId;
  final int sortNumber;

  const SocialMedia({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
    this.extraValueOne = "",
    this.extraValueTwo = "",
    this.parentId = 0,
    this.sortNumber = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        logo,
        extraValueOne,
        extraValueTwo,
        parentId,
        sortNumber,
      ];
}
