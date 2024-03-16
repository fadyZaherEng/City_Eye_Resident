import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class Page extends Equatable {
  final String code;
  final List<PageField> fields;

  const Page({
    this.code = "",
    this.fields = const [],
  });

  @override
  List<Object?> get props => [
        code,
        fields,
      ];
}
