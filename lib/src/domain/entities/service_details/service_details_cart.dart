import 'package:city_eye/src/data/sources/remote/city_eye/service_details/request/submit_service_details_cart_request.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class ServiceDetailsCart extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final int maxCount;
  final int minCount;
  final int quantity;
  final bool isSelected;
  final double totalPrice;
  final String startDate;
  final String endDate;
  final double serviceRate;
  final int serviceDaysLimit;
  final bool isCountType;
  final List<PageField> servicePackageQuestions;

  const ServiceDetailsCart({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.price = 0,
    this.maxCount = 0,
    this.minCount = 0,
    this.quantity = 0,
    this.isSelected = false,
    this.totalPrice = 0.0,
    this.startDate = "",
    this.endDate = "",
    this.serviceRate = 0.0,
    this.serviceDaysLimit = 0,
    this.isCountType = false,
    this.servicePackageQuestions = const [],
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        price,
        maxCount,
        minCount,
        quantity,
        isSelected,
        totalPrice,
        startDate,
        endDate,
        serviceRate,
        serviceDaysLimit,
        isCountType,
        servicePackageQuestions,
      ];

  ServiceDetailsCart copyWith({
    int? id,
    String? name,
    String? description,
    int? price,
    int? maxCount,
    int? minCount,
    int? quantity,
    bool? isSelected,
    double? totalPrice,
    String? startDate,
    String? endDate,
    double? serviceRate,
    int? serviceDaysLimit,
    bool? isCountType,
    List<PageField>? servicePackageQuestions,
  }) {
    return ServiceDetailsCart(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      maxCount: maxCount ?? this.maxCount,
      minCount: minCount ?? this.minCount,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
      totalPrice: totalPrice ?? this.totalPrice,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      serviceRate: serviceRate ?? this.serviceRate,
      serviceDaysLimit: serviceDaysLimit ?? this.serviceDaysLimit,
      isCountType: isCountType ?? this.isCountType,
      servicePackageQuestions:
          servicePackageQuestions ?? this.servicePackageQuestions,
    );
  }
}

extension ServiceDetailsCartExtension on ServiceDetailsCart {
  SubmitServiceDetailsCartRequest mapToSubmitServiceDetailsCartRequest() {
    return SubmitServiceDetailsCartRequest(
      packageId: id,
      serviceCount: quantity,
      remoteServicePackagesQuestion: servicePackageQuestions
          .map((e) => e.mapToServicePackageQuestionRequest())
          .toList(),
    );
  }
}

extension ServiceDetailsCartListExtension on List<ServiceDetailsCart> {
  List<SubmitServiceDetailsCartRequest>
      mapToSubmitServiceDetailsCartRequests() {
    return map((e) => e.mapToSubmitServiceDetailsCartRequest()).toList();
  }
}
