import 'package:equatable/equatable.dart';

final class SocialMediaType extends Equatable {
  final int id;
  final String name;
  final String code;
  final String logo;

  const SocialMediaType({
    this.id = 0,
    this.name = "",
    this.code = "",
    this.logo = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'logo': logo,
    };
  }

  factory SocialMediaType.fromMap(Map<String, dynamic> map) {
    return SocialMediaType(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
      logo: map['logo'] as String,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        code,
        logo,
      ];
}
