import 'package:city_eye/src/domain/entities/settings/compound_configuration.dart';
import 'package:city_eye/src/domain/entities/settings/multi_media_configuration.dart';

final class SupportDetailsConfigurationUseCase {
  MultiMediaConfiguration call(CompoundConfiguration compoundConfiguration) {
    final supportCompoundMultiMediaConfiguration = compoundConfiguration
        .listOfMultiMediaConfiguration
        .singleWhere((element) => element.pageCode == 'Support');
    return supportCompoundMultiMediaConfiguration;
  }
}
