// import 'package:city_eye/src/domain/entities/settings/compound_multi_media_configuration.dart';
// import 'package:city_eye/src/domain/entities/settings/multi_media_configuration.dart';
//
// mixin _ExtractSupportMultiMedia {
//   CompoundMultiMediaConfiguration getSupportImageMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration);
//
//   CompoundMultiMediaConfiguration getSupportAudioMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration);
//
//   CompoundMultiMediaConfiguration getSupportVideoMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration);
//
//   CompoundMultiMediaConfiguration getSupportTextMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration);
//
// }
//
// final class GetSupportMultiMediaUseCase with _ExtractSupportMultiMedia {
//   @override
//   CompoundMultiMediaConfiguration getSupportImageMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration) {
//     final imageMultiMediaType = multiMediaConfiguration
//         .compoundMultiMediaConfiguration
//         .singleWhere((element) => element.multiMediaType.code == 'image');
//     return imageMultiMediaType;
//   }
//
//   @override
//   CompoundMultiMediaConfiguration getSupportAudioMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration) {
//     final audioMultiMediaType = multiMediaConfiguration
//         .compoundMultiMediaConfiguration
//         .singleWhere((element) => element.multiMediaType.code == 'audio');
//     return audioMultiMediaType;
//   }
//
//   @override
//   CompoundMultiMediaConfiguration getSupportVideoMultiMediaConfiguration(
//       MultiMediaConfiguration multiMediaConfiguration) {
//     final videoMultiMediaType = multiMediaConfiguration
//         .compoundMultiMediaConfiguration
//         .singleWhere((element) => element.multiMediaType.code == 'video');
//     return videoMultiMediaType;
//   }
//
//   @override
//   CompoundMultiMediaConfiguration getSupportTextMultiMediaConfiguration(MultiMediaConfiguration multiMediaConfiguration) {
//     final textMultiMediaType = multiMediaConfiguration
//         .compoundMultiMediaConfiguration
//         .singleWhere((element) => element.multiMediaType.code == 'text');
//     return textMultiMediaType;
//
//   }
// }
