import 'package:city_eye/src/data/sources/remote/city_eye/settings/request/page_code_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_fields_request.g.dart';

@JsonSerializable()
class PageFieldsRequest {
  @JsonKey(name: 'compoundId')
  final int compoundId;
  @JsonKey(name: 'userTypeId')
  final int userTypeId;

  @JsonKey(name: 'generalExtrafield')
  final List<PageCodeRequest> generalExtrafield;

  const PageFieldsRequest({
    required this.compoundId,
    required this.userTypeId,
    required this.generalExtrafield,
  });

  factory PageFieldsRequest.fromJson(Map<String, dynamic> json) =>
      _$PageFieldsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PageFieldsRequestToJson(this);

  @override
  String toString() {
    return 'PageFieldsRequest{compoundId: $compoundId, userTypeId: $userTypeId, generalExtrafield: $generalExtrafield}';
  }
}
