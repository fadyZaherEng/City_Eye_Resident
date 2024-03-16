import 'package:city_eye/src/domain/entities/settings/multi_media_type.dart';
import 'package:equatable/equatable.dart';

final class CompoundMultiMediaConfiguration extends Equatable {
  final int id;
  final bool isVisible;
  final int minCount;
  final int maxCount;
  final int maxTime;
  final int maxSize;
  final bool isMulti;
  final MultiMediaType multiMediaType;

  const CompoundMultiMediaConfiguration({
    this.id = 0,
    this.isVisible = false,
    this.minCount = 0,
    this.maxCount = 0,
    this.maxTime = 0,
    this.maxSize = 0,
    this.isMulti = false,
    this.multiMediaType =
        const MultiMediaType(),
  });


  @override
  List<Object> get props => [
        id,
        isVisible,
        minCount,
        maxCount,
        maxTime,
        maxSize,
        isMulti,
        multiMediaType,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isVisible': isVisible,
      'minCount': minCount,
      'maxCount': maxCount,
      'maxTime': maxTime,
      'maxSize': maxSize,
      'isMulti': isMulti,
      'multiMediaType': multiMediaType.toMap()
    };
  }

  factory CompoundMultiMediaConfiguration.fromMap(Map<String, dynamic> map) {
    return CompoundMultiMediaConfiguration(
      id: map['id'] as int,
      isVisible: map['isVisible'] as bool,
      minCount: map['minCount'] as int,
      maxCount: map['maxCount'] as int,
      maxTime: map['maxTime'] as int,
      maxSize: map['maxSize'] as int,
      isMulti: map['isMulti'] as bool,
      multiMediaType: MultiMediaType.fromMap(map['multiMediaType']),
    );
  }
}
