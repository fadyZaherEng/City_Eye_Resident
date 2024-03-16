import 'package:equatable/equatable.dart';

class UserInformation extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final String email;
  final String mobile;
  final String image;
  final bool status;
  final bool otpStatus;
  final int subscriberId;
  final String contractDate;

  const UserInformation({
    this.id = -1,
    this.name = "",
    this.fullName = "",
    this.email = "",
    this.mobile = "",
    this.image = "",
    this.status = false,
    this.otpStatus = false,
    this.subscriberId = 0,
    this.contractDate = "",
  });

  UserInformation copyWith({
    int? id,
    String? name,
    String? fullName,
    String? email,
    String? mobile,
    String? image,
    bool? status,
    bool? otpStatus,
    int? subscriberId,
    String? contractDate,
  }) {
    return UserInformation(
      id: id ?? this.id,
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      image: image ?? this.image,
      status: status ?? this.status,
      otpStatus: otpStatus ?? this.otpStatus,
      subscriberId: subscriberId ?? this.subscriberId,
      contractDate: contractDate ?? this.contractDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'image': image,
      'status': status,
      'otpStatus': otpStatus,
      'subscriberId': subscriberId,
      'contractDate': contractDate,
    };
  }

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      id: map['id'],
      name: map['name'],
      fullName: map['fullName'],
      email: map['email'],
      mobile: map['mobile'],
      image: map['image'],
      status: map['status'],
      otpStatus: map['otpStatus'],
      subscriberId: map['subscriberId'],
      contractDate: map['contractDate'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        fullName,
        email,
        mobile,
        image,
        status,
        otpStatus,
        subscriberId,
      ];
}
