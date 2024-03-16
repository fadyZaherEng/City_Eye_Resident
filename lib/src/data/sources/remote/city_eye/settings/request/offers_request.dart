import 'package:json_annotation/json_annotation.dart';

part 'offers_request.g.dart';

@JsonSerializable()
class OffersRequest {
  @JsonKey(name: 'pageCode')
  final String pageCode;

  OffersRequest({required this.pageCode});

  factory OffersRequest.fromJson(Map<String, dynamic> json) =>
      _$OffersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OffersRequestToJson(this);
}
