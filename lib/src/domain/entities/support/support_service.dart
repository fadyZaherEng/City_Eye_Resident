import 'package:equatable/equatable.dart';

class SupportService extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const SupportService({
    this.id = 0,
    this.name = "",
    this.imageUrl = "",
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
  ];
}
