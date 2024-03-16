import 'package:equatable/equatable.dart';

class BadgeUsers extends Equatable {
  final int id;
  final String fullName;
  final String userName;
  final String mobile;
  final String email;
  final int subscriberId;
  final String image;

  const BadgeUsers({
    this.id = 0,
    this.fullName = "",
    this.userName = "",
    this.mobile = "",
    this.email = "",
    this.subscriberId = 0,
    this.image = "",
  });

  @override
  List<Object> get props => [
        id,
        fullName,
        userName,
        mobile,
        email,
        subscriberId,
        image,
      ];
}
