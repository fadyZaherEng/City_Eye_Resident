import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_service_package.dart';
import 'package:city_eye/src/domain/entities/services/my_subscription.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_my_subscriptions.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteMySubscriptions {
  final int? id;
  final RemoteServicePackages? servicePackages;
  final int? serviceCount;
  final int? price;
  final int? discount;
  final int? totalPrice;
  final int? sessionNo;
  final String? expireDate;
  final String? qrImage;
  final int? pinCode;

  RemoteMySubscriptions({
    this.id = 0,
    this.servicePackages = const RemoteServicePackages(),
    this.serviceCount = 0,
    this.price = 0,
    this.discount = 0,
    this.totalPrice = 0,
    this.sessionNo = 0,
    this.expireDate = "",
    this.qrImage = "",
    this.pinCode = 0,
  });

  factory RemoteMySubscriptions.fromJson(Map<String, dynamic> json) =>
      _$RemoteMySubscriptionsFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteMySubscriptionsToJson(this);
}

extension RemoteMySubscriptionsExtension on RemoteMySubscriptions {
  MySubscription mapToDomain() {
    return MySubscription(
      id: id ?? 0,
      servicePackages: servicePackages!.mapToDomain(),
      serviceCount: serviceCount ?? 0,
      price: price ?? 0,
      discount: discount ?? 0,
      totalPrice: totalPrice ?? 0,
      sessionNo: sessionNo ?? 0,
      expireDate: expireDate ?? "",
      qrImage: qrImage ?? "",
      pinCode: pinCode ?? 0,
    );
  }
}

extension RemoteMySubscriptionsListExtension on List<RemoteMySubscriptions> {
  List<MySubscription> mapToDomain() {
    return map((e) => e.mapToDomain()).toList();
  }
}
