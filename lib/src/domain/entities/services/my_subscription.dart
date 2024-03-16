import 'package:city_eye/src/domain/entities/services/service_package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class MySubscription extends Equatable {
  final int id;
  final ServicePackages servicePackages;
  final int serviceCount;
  final int price;
  final int discount;
  final int totalPrice;
  final int sessionNo;
  final String expireDate;
  final String qrImage;
  final int pinCode;
  final GlobalKey? key;

  const MySubscription({
    this.id = 0,
    this.servicePackages = const ServicePackages(),
    this.serviceCount = 0,
    this.price = 0,
    this.discount = 0,
    this.totalPrice = 0,
    this.sessionNo = 0,
    this.expireDate = "",
    this.qrImage = "",
    this.pinCode = 0,
    this.key,
  });

  MySubscription copyWith({
    int? id,
    ServicePackages? servicePackages,
    int? serviceCount,
    int? price,
    int? discount,
    int? totalPrice,
    int? sessionNo,
    String? expireDate,
    String? qrImage,
    int? pinCode,
    GlobalKey? key,
  }) =>
      MySubscription(
        id: id ?? this.id,
        servicePackages: servicePackages ?? this.servicePackages,
        serviceCount: serviceCount ?? this.serviceCount,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        totalPrice: totalPrice ?? this.totalPrice,
        sessionNo: sessionNo ?? this.sessionNo,
        expireDate: expireDate ?? this.expireDate,
        qrImage: qrImage ?? this.qrImage,
        pinCode: pinCode ?? this.pinCode,
        key: key ?? this.key,
      );

  @override
  List<Object> get props => [
        id,
        servicePackages,
        serviceCount,
        price,
        discount,
        totalPrice,
        sessionNo,
        expireDate,
        qrImage,
        pinCode,
      ];
}
