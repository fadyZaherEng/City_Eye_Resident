import 'package:equatable/equatable.dart';

class UserDeviceInfo extends Equatable {
  final String deviceToken;
  final bool isAllowNotification;
  final bool isCurrentActive;
  final String lastLangCode;

  const UserDeviceInfo({
    this.deviceToken = '',
    this.isAllowNotification = false,
    this.isCurrentActive = true,
    this.lastLangCode = '',
  });

  UserDeviceInfo copyWith({
    String? deviceToken,
    bool? isAllowNotification,
    bool? isCurrentActive,
    String? lastLangCode,
  }) {
    return UserDeviceInfo(
      deviceToken: deviceToken ?? this.deviceToken,
      isAllowNotification: isAllowNotification ?? this.isAllowNotification,
      isCurrentActive: isCurrentActive ?? this.isCurrentActive,
      lastLangCode: lastLangCode ?? this.lastLangCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'deviceToken': deviceToken,
      'isAllowNotification': isAllowNotification,
      'isCurrentActive': isCurrentActive,
      'lastLangCode': lastLangCode,
    };
  }

  factory UserDeviceInfo.fromMap(Map<String, dynamic> map) {
    return UserDeviceInfo(
      deviceToken: map['deviceToken'],
      isAllowNotification: map['isAllowNotification'],
      isCurrentActive: map['isCurrentActive'],
      lastLangCode: map['lastLangCode'],
    );
  }

  @override
  List<Object?> get props => [
        deviceToken,
        isAllowNotification,
        isCurrentActive,
        lastLangCode,
      ];
}
