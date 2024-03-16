import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_category.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/entity/remote_status.dart';
import 'package:city_eye/src/domain/entities/support/orders.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_orders.g.dart';

@JsonSerializable()
class RemoteOrders {
  final int? id;
  final String? date;
  final String? time;
  final bool? isRating;
  final int? ratingValue;
  final String? ratingComment;
  final RemoteCategory? category;
  final List<RemoteStatus>? statusList;
  final int? paymentId;

  const RemoteOrders({
    this.id= 0,
    this.date = "",
    this.time = "",
    this.isRating = false,
    this.ratingValue = 0,
    this.ratingComment = "",
    this.category = const RemoteCategory(),
    this.statusList = const [],
    this.paymentId = 0,
  });

  factory RemoteOrders.fromJson(Map<String, dynamic> json) => _$RemoteOrdersFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteOrdersToJson(this);

}

extension RemoteOrdersExtension on RemoteOrders {
  Orders mapToDomain() {
    return Orders(
      id: id ?? 0,
      date: date ?? "",
      time: time ?? "",
      isRating: isRating ?? false,
      ratingValue: ratingValue ?? 0,
      ratingComment: ratingComment ?? "",
      category: (category ?? const RemoteCategory()).mapToDomain(),
      statusList: (statusList ?? const []).mapToDomain(),
      paymentId: paymentId ?? 0,
    );
  }
}

extension RemoteOrdersListExtension on List<RemoteOrders>? {
  List<Orders> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}