import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final String mobile;

  const ResetPassword({
    this.mobile = "",
  });

  @override
  List<Object?> get props => [mobile];
}
