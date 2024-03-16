import 'package:equatable/equatable.dart';

final class HomeCompoundItem extends Equatable {
  final int id;
  final String code;
  final bool isVisible;

  const HomeCompoundItem({
    this.id = 0,
    this.code = "",
    this.isVisible = false,
  });

  @override
  List<Object> get props => [id, code, isVisible];
}
