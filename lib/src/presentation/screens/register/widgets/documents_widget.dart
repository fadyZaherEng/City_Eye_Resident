import 'package:city_eye/src/config/routes/routes_manager.dart';
import 'package:city_eye/src/core/utils/questions_code.dart';
import 'package:city_eye/src/domain/entities/gallery/gallery_attachment.dart';
import 'package:city_eye/src/domain/entities/gallery/images_screen.dart';
import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/document_file_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/document_image_widget.dart';
import 'package:city_eye/src/presentation/widgets/images_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DocumentsWidget extends StatefulWidget {
  final ScrollController scrollController;
  final List<PageField> documents;
  final void Function(PageField document) onTapImage;
  final void Function(PageField document) onTapFile;
  final void Function(PageField document) deleteFileAction;
  final void Function(PageField document) deleteImageAction;
  final Function(PageField document,int min,int max) onAddMultipleImageTap;
  final Function(PageField document, int index) onDeleteMultipleImageTap;
  bool isImagesRequired;
  int maxMultipleImages;
  int minMultipleImages;

  DocumentsWidget({
    Key? key,
    required this.onTapImage,
    required this.onAddMultipleImageTap,
    required this.onDeleteMultipleImageTap,
    required this.onTapFile,
    required this.deleteFileAction,
    required this.deleteImageAction,
    required this.documents,
     this.maxMultipleImages = 1,
     this.minMultipleImages = 1,
    this.isImagesRequired = false,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<DocumentsWidget> createState() => _RegisterDocumentWidgetState();
}

class _RegisterDocumentWidgetState extends State<DocumentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            controller: widget.scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: widget.documents.length,
            itemBuilder: (BuildContext context, int index) {
              widget.documents[index] = widget.documents[index].copyWith(
                index: index,
              );
              if (widget.documents[index].code == QuestionsCode.image) {
                return DocumentImageWidget(
                  globalKey: widget.documents[index].key,
                  description: widget.documents[index].description,
                  onTap: () {
                    widget.onTapImage(
                      widget.documents[index],
                    );
                  },
                  image: widget.documents[index].value,
                  name: widget.documents[index].label,
                  deleteImageAction: (String value) {
                    widget.deleteImageAction(
                      widget.documents[index],
                    );
                  },
                  errorMessage: widget.documents[index].errorMessage,
                );
              } else if (widget.documents[index].code == QuestionsCode.file) {
                return DocumentFileWidget(
                  globalKey: widget.documents[index].key,
                  description: widget.documents[index].description,
                  onTap: () {
                    widget.onTapFile(
                      widget.documents[index],
                    );
                  },
                  file: widget.documents[index].value,
                  deleteFileAction: (String value) {
                    widget.deleteFileAction(
                      widget.documents[index],
                    );
                  },
                  fileValid: widget.documents[index].fileValid,
                  fileName: widget.documents[index].label,
                  errorMessage: widget.documents[index].errorMessage,
                );
              } else if (widget.documents[index].code ==
                  QuestionsCode.multiImage) {
                return ImageWidgets(
                  globalKey: widget.documents[index].key,
                  images: widget.documents[index].imagesList,
                  imagesMaxNumber: widget.documents[index].maxCount,
                  imagesMinNumber: widget.documents[index].minCount,
                  isRequired: widget.isImagesRequired,
                  title: widget.documents[index].label,
                  onClearImageTap: (int mIndex) {
                    widget.onDeleteMultipleImageTap(
                        widget.documents[index], mIndex);
                  },
                  onAddImageTap: () {
                    widget.onAddMultipleImageTap(widget.documents[index],widget.documents[index].minCount,widget.documents[index].maxCount);
                  },
                  onTapImage: (index){
                    List<GalleryAttachment> galleryImages = [];
                    for (var image in widget.documents[index].imagesList) {
                      galleryImages.add(GalleryAttachment(attachment: image.path));
                    }
                    Navigator.pushNamed(context, Routes.galleryImages,
                        arguments: GalleryImages(
                          initialIndex: index,
                          images: galleryImages,
                        ));
                  },
                  isNeverHide: true,
                );
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
