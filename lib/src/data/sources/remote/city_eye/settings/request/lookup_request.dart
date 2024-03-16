import 'package:json_annotation/json_annotation.dart';

part 'lookup_request.g.dart';


@JsonSerializable()
class LookupRequest {
  @JsonKey(name: 'lookupCode')
  final String lookupCode;

  const LookupRequest({
    required this.lookupCode,
  });

  factory LookupRequest.fromJson(Map<String, dynamic> json) =>
      _$LookupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LookupRequestToJson(this);


}
