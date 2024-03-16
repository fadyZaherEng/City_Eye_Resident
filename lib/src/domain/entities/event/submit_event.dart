import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

final class SubmitEvent extends Equatable {
  final int transactionId;
  final int countCurrentJoin;
  final List<PageField> fields;

  const SubmitEvent({
    this.transactionId = 0,
    this.countCurrentJoin = 0,
    this.fields = const [],
  });

  @override
  List<Object> get props => [
        transactionId,
    countCurrentJoin,
        fields,
      ];

  @override
  String toString() {
    return 'SubmitEvent{transactionId: $transactionId, countCurrentJoin: $countCurrentJoin fields: $fields}';
  }
}
