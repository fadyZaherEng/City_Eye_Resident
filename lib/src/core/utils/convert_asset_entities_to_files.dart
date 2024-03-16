import 'dart:io';
import 'package:city_eye/src/core/utils/compress_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

Future<List<File>> convertAssetEntitiesToFiles(
    List<AssetEntity>? assetEntities) async {
  List<File> files = [];

  if (assetEntities == null) {
    return files;
  }

  for (AssetEntity assetEntity in assetEntities) {
    File? file = await assetEntity.file;
    if (file != null) {
      XFile? imageFile = await compressFile(File(file.path));
      if (imageFile != null) {
        files.add(File(imageFile.path));
      } else {
        files.add(file);
      }
    }
  }

  return files;
}
