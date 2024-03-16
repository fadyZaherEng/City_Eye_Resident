import 'package:equatable/equatable.dart';

class Invitation extends Equatable {
  final int id;
  final String otpNumber;
  final String invitationUrl;

  const Invitation({
    this.id = 0,
    this.otpNumber = "",
    this.invitationUrl = "",
  });

  @override
  List<Object?> get props => [
        id,
        otpNumber,
        invitationUrl,
      ];
}
