// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_rating_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRatingRequest _$OrderRatingRequestFromJson(Map<String, dynamic> json) =>
    OrderRatingRequest(
      id: json['id'] as int,
      ratingValue: json['ratingValue'] as int,
      ratingComment: json['ratingComment'] as String,
    );

Map<String, dynamic> _$OrderRatingRequestToJson(OrderRatingRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ratingValue': instance.ratingValue,
      'ratingComment': instance.ratingComment,
    };
