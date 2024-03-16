import 'package:equatable/equatable.dart';

class Status extends Equatable {
  final int id;
  final String name;
  final String colorCode;
  final String logo;
  final bool isCompleted;
  final bool isCurrent;
  final String captionStatusCode;

  const Status({
    this.id = 0,
    this.name = "",
    this.colorCode = "",
    this.logo = "",
    this.isCompleted = false,
    this.isCurrent = false,
    this.captionStatusCode = "",
  });

  @override
  List<Object?> get props => [
    id,
    name,
    colorCode,
    logo,
    isCompleted,
    captionStatusCode,
  ];
}
