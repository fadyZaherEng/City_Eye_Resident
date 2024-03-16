import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class Info extends Equatable {
  final String image;
  final String name;
  final String email;
  final String mobileNumber;
  final List<PageField> fields;

  const Info({
    this.image = "",
    this.name = "",
    this.email = "",
    this.mobileNumber = "",
    this.fields = const [],
  });

  Info copyWith({
    String? image,
    String? name,
    String? email,
    String? mobileNumber,
    List<PageField>? fields,
  }) {
    return Info(
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      fields: fields ?? this.fields,
    );
  }

  @override
  List<Object?> get props => [
        image,
        name,
        email,
        mobileNumber,
        fields,
      ];
}
