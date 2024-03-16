import 'package:json_annotation/json_annotation.dart';

part 'order_rating_request.g.dart';

@JsonSerializable()
class OrderRatingRequest {
  final int id;
  final int ratingValue;
  final String ratingComment;

  const OrderRatingRequest({
    required this.id,
    required this.ratingValue,
    required this.ratingComment
  });

  factory OrderRatingRequest.fromJson(Map<String, dynamic> json) => _$OrderRatingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRatingRequestToJson(this);
}