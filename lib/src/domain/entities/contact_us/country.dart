import 'package:equatable/equatable.dart';

final class Country extends Equatable {
  final int id;
  final String name;
  final String code;
  final String extraValue1;
  final String extraValue2;
  final int parentId;
  final String logo;
  final int sortNo;

  const Country({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.extraValue1 = "",
    this.extraValue2 = "",
    this.parentId = 0,
    this.logo = "",
    this.sortNo = 0,
  });

  @override
  List<Object> get props => [
        id,
        name,
        code,
        extraValue1,
        extraValue2,
        parentId,
        logo,
        sortNo,
      ];
}
