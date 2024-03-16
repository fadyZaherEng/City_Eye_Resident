import 'package:city_eye/src/domain/entities/qr/qr_rule.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class QrResponse extends Equatable {
  final List<PageField> questions;
  final List<QrRule> rules;

  const QrResponse({
    this.questions = const [],
    this.rules = const [],
  });

  @override
  List<Object?> get props => [questions, rules];
}
