import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'support_details_date_request.g.dart';

@JsonSerializable()
final class SupportDetailsDateRequest extends Equatable {
  final int categoryId;
  final String date;

  const SupportDetailsDateRequest({
    required this.categoryId,
    required this.date,
  });

  factory SupportDetailsDateRequest.fromJson(Map<String, dynamic> json) =>
      _$SupportDetailsDateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupportDetailsDateRequestToJson(this);

  @override
  List<Object> get props => [categoryId, date];
}
