import 'package:equatable/equatable.dart';

class GalleryAttachment extends Equatable {
  final int id;
  final String name;
  final String attachment;
  final int sortNo;

  const GalleryAttachment({
    this.id = 0,
    this.name = "",
    this.attachment = "",
    this.sortNo = 0,
  });

  @override
  List<Object> get props => [id, name, attachment, sortNo];
}
