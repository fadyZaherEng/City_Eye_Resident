import 'package:equatable/equatable.dart';

class EventAttachments extends Equatable {
  final int id;
  final String name;
  final String attachment;

  const EventAttachments({
    this.id = 0,
    this.name = "",
    this.attachment = "",
  });

  @override
  List<Object?> get props => [
        id,
        name,
        attachment,
      ];
}
