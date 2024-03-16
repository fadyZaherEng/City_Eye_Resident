import 'package:json_annotation/json_annotation.dart';

part 'order_cancel_request.g.dart';

@JsonSerializable()
class OrderCancelRequest {
  final int requestId;
  final int statusId;

  OrderCancelRequest({
    required this.requestId,
    this.statusId = 5,
  });

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) => _$OrderCancelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancelRequestToJson(this);

}
