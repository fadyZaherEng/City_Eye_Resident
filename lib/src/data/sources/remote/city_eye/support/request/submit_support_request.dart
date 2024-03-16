import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_support_request.g.dart';

@JsonSerializable()
final class SubmitSupportRequest extends Equatable {
  final String description;
  final int categoryId;
  final int timeId;
  final String date;
  final bool isSupplier;
  final bool canRequestOnSameDay;
  final int bufferPerDay;
  final int bufferPerSlot;
  final int supplierId;

  const SubmitSupportRequest({
    required this.description,
    required this.categoryId,
    required this.timeId,
    required this.date,
    required this.isSupplier,
    required this.canRequestOnSameDay,
    required this.bufferPerDay,
    required this.bufferPerSlot,
    required this.supplierId,
  });

  factory SubmitSupportRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSupportRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSupportRequestToJson(this);

  @override
  List<Object> get props => [description, categoryId, timeId, date, isSupplier, canRequestOnSameDay, bufferPerDay, bufferPerSlot];

  @override
  String toString() {
    return 'SubmitSupportRequest{description: $description, categoryId: $categoryId, timeId: $timeId, date: $date}';
  }
}
