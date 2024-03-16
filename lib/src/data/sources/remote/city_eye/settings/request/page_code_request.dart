import 'package:json_annotation/json_annotation.dart';

part 'page_code_request.g.dart';

@JsonSerializable()
class PageCodeRequest {
  @JsonKey(name: 'pageCode')
  final String pageCode;

  const PageCodeRequest({
    required this.pageCode,
  });

  factory PageCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$PageCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PageCodeRequestToJson(this);
}
