import 'package:equatable/equatable.dart';

class NotificationCount extends Equatable {
  final int count;

  const NotificationCount({this.count = 0});

  @override
  List<Object?> get props => [count];
}
