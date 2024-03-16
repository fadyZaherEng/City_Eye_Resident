import 'package:city_eye/src/domain/entities/settings/compound_multi_media_configuration.dart';
import 'package:equatable/equatable.dart';

final class MultiMediaConfiguration extends Equatable {
  final int id;
  final int pageId;
  final String pageCode;
  final List<CompoundMultiMediaConfiguration> compoundMultiMediaConfiguration;

  const MultiMediaConfiguration({
    this.id = 0,
    this.pageId = 0,
    this.pageCode = "",
    this.compoundMultiMediaConfiguration = const [],
  });

  @override
  List<Object> get props => [
        id,
        pageId,
        pageCode,
        compoundMultiMediaConfiguration,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pageId': pageId,
      'pageCode': pageCode,
      'compoundMultiMediaConfiguration':
          compoundMultiMediaConfiguration.map((e) => e.toMap()).toList(),
    };
  }

  factory MultiMediaConfiguration.fromMap(Map<String, dynamic> map) {
    return MultiMediaConfiguration(
      id: map['id'] as int,
      pageId: map['pageId'] as int,
      pageCode: map['pageCode'] as String,
      compoundMultiMediaConfiguration:
          List<CompoundMultiMediaConfiguration>.from(
              map['compoundMultiMediaConfiguration']
                  ?.map((x) => CompoundMultiMediaConfiguration.fromMap(x))),
    );
  }
}
