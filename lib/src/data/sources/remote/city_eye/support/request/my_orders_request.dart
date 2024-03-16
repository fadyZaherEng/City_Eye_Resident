import 'package:json_annotation/json_annotation.dart';

part 'my_orders_request.g.dart';

@JsonSerializable()
class MyOrdersRequest {
  final bool isCurrent;

  MyOrdersRequest({
    required this.isCurrent,
  });

  factory MyOrdersRequest.fromJson(Map<String, dynamic> json) => _$MyOrdersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrdersRequestToJson(this);

}