import 'package:city_eye/src/data/sources/remote/city_eye/service_details/entity/remote_service_packages_question.dart';
import 'package:city_eye/src/domain/entities/service_details/service_details_cart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_service_details_cart.g.dart';

@JsonSerializable(explicitToJson: true)
final class RemoteServiceDetailsCart {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final int? maxCount;
  final int? minCount;
  final String? startDate;
  final String? endDate;
  final double? serviceRate;
  final int? serviceDaysLimit;
  final bool? isCountType;
  final List<RemoteServicePackagesQuestion>? servicePackageQuestions;

  RemoteServiceDetailsCart({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.price = 0,
    this.maxCount = 0,
    this.minCount = 0,
    this.startDate = "",
    this.endDate = "",
    this.serviceRate = 0.0,
    this.serviceDaysLimit = 0,
    this.isCountType = false,
    this.servicePackageQuestions = const [],
  });

  factory RemoteServiceDetailsCart.fromJson(Map<String, dynamic> json) =>
      _$RemoteServiceDetailsCartFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteServiceDetailsCartToJson(this);
}

extension RemoteServiceDetailsCartExtension on RemoteServiceDetailsCart {
  ServiceDetailsCart mapToDomain() {
    return ServiceDetailsCart(
      id: id ?? 0,
      name: name ?? "",
      description: description ?? "",
      price: price ?? 0,
      maxCount: maxCount ?? 0,
      minCount: minCount ?? 0,
      startDate: startDate ?? "",
      endDate: endDate ?? "",
      serviceRate: serviceRate ?? 0.0,
      serviceDaysLimit: serviceDaysLimit ?? 0,
      isCountType: isCountType ?? false,
      servicePackageQuestions:
          servicePackageQuestions?.map((e) => e.mapToDomain).toList() ?? [],
    );
  }
}

extension RemoteServiceDetailsCartExtensionList
    on List<RemoteServiceDetailsCart>? {
  List<ServiceDetailsCart> get mapToDomain {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
