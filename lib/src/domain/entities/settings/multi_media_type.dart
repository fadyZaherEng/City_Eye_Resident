import 'package:equatable/equatable.dart';

final class MultiMediaType extends Equatable {
  final int id;
  final String code;
  final String logo;

  const MultiMediaType({
    this.id = 0,
    this.code = "",
    this.logo = "",
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'logo': logo,
    };
  }

  factory MultiMediaType.fromMap(Map<String, dynamic> map) {
    return MultiMediaType(
      id: map['id'] as int,
      code: map['code'] as String,
      logo: map['logo'] as String,
    );
  }

  @override
  List<Object> get props => [
        id,
        code,
        logo,
      ];


}
