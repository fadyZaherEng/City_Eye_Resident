import 'package:equatable/equatable.dart';

class WallAttachment extends Equatable {
  final int id;
  final String name;
  final String attachment;
  final int sortNo;

  const WallAttachment({
    this.id = 0,
    this.name = "",
    this.attachment = "",
    this.sortNo = 0,
  });

  @override
  List<Object?> get props => [id, name, attachment, sortNo];
}
