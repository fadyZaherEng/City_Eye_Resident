import 'package:city_eye/flavors.dart';
import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/base/widget/base_stateful_widget.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/profile/profile_file.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/file_document_widget.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/file_image_widget.dart';
import 'package:city_eye/src/presentation/screens/profile/widgets/file_images_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_button_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';

class FilesWidget extends BaseStatefulWidget {
  final List<ProfileFile> files;
  final Function(ProfileFile) onDelete;
  final Function(ProfileFile) onEdit;
  final Function(ProfileFile) onTapFile;
  final Function(List<ProfileFile>) onSave;
  final Function(ProfileFile) onChangeDate;
  final Function(ProfileFile, int) onAddMultiImage;
  final Function(ProfileFile, int) onDeleteMultiImage;
  final Function(List<String>, int) onTapMultiImage;

  const FilesWidget({
    Key? key,
    required this.files,
    required this.onDelete,
    required this.onEdit,
    required this.onTapFile,
    required this.onSave,
    required this.onChangeDate,
    required this.onAddMultiImage,
    required this.onDeleteMultiImage,
    required this.onTapMultiImage,
  }) : super(key: key);

  @override
  BaseState<FilesWidget> baseCreateState() => _FilesWidgetState();
}

class _FilesWidgetState extends BaseState<FilesWidget> {
  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          fit: StackFit.loose,
          children: [
            CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: widget.files.isNotEmpty
                    ? Column(
                        children: [
                          ..._buildFiles(widget.files),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      )
                    : _buildEmptyWidget(),
              )
            ]),
            if (widget.files.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomButtonWidget(
                  onTap: () {
                    widget.onSave(widget.files);
                  },
                  text: S.of(context).save,
                  width: double.infinity,
                  backgroundColor: F.isNiceTouch
                      ? ColorSchemes.ghadeerDarkBlue
                      : ColorSchemes.primary,
                ),
              ),
          ],
        ));
  }

  List<Widget> _buildFiles(List<ProfileFile> files) {
    List<Widget> widgets = [];
    for (var file in files) {
      if (file.code == QuestionsCode.image) {
        widgets.add(FileImageWidget(
          key: file.key,
          file: file,
          onDelete: (file) {
            widget.onDelete(file);
          },
          onEdit: (file) {
            widget.onEdit(file);
          },
          onTapImage: (file) {
            widget.onTapFile(file);
          },
          onChangeDate: (file) {
            widget.onChangeDate(file);
          },
        ));
      } else if (file.code == QuestionsCode.file) {
        widgets.add(FileDocumentWidget(
          key: file.key,
          file: file,
          onDelete: (file) {
            widget.onDelete(file);
          },
          onEdit: (file) {
            widget.onEdit(file);
          },
          onTapDocument: (file) {
            widget.onTapFile(file);
          },
          onChangeDate: (file) {
            widget.onChangeDate(file);
          },
        ));
      } else if (file.code == QuestionsCode.multiImage) {
        widgets.add(FileImagesWidget(
          file: file,
          onChangeDate: (file) {
            widget.onChangeDate(file);
          },
          onAddMultiImage: (file, index) {
            widget.onAddMultiImage(file, index);
          },
          onDeleteImage: (file, index) {
            widget.onDeleteMultiImage(file, index);
          },
          onTapImage: (images, index) {
            widget.onTapMultiImage(images, index);
          },
        ));
      }
    }
    return widgets;
  }

  Widget _buildEmptyWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomEmptyListWidget(
            imagePath: ImagePaths.noServices,
            text: S.of(context).noFilesYet,
            isRefreshable: false,
          ),
        ],
      );
}
