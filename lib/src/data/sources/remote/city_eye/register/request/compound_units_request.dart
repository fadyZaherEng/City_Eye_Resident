import 'package:json_annotation/json_annotation.dart';

part 'compound_units_request.g.dart';

@JsonSerializable()
class CompoundUnitsRequest {
  @JsonKey(name: 'userTypeId')
  final int userTypeId;
  @JsonKey(name: 'compoundId')
  final int compoundId;

  const CompoundUnitsRequest({
    required this.userTypeId,
    required this.compoundId,
  });

  factory CompoundUnitsRequest.fromJson(Map<String, dynamic> json) =>
      _$CompoundUnitsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompoundUnitsRequestToJson(this);

  @override
  String toString() {
    return 'CompoundUnitsRequest{userTypeId: $userTypeId, compoundId: $compoundId}';
  }
}
