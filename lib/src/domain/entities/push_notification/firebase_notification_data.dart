import 'dart:convert';

class FirebaseNotificationData {
  final String message;
  final String code;
  final int id;
  final int unitId;

  FirebaseNotificationData({
    this.message = "",
    this.code = "",
    this.id = 0,
    this.unitId = 0,
  });

  factory FirebaseNotificationData.fromJson(Map<String, dynamic> json) {
    return FirebaseNotificationData(
      id: int.parse(json['id']),
      message: json['title'] ?? "",
      code: json['view'] ?? "",
      unitId: int.parse(json['sectionid']),
    );
  }

  factory FirebaseNotificationData.fromMap(Map<String, dynamic> map) {
    return FirebaseNotificationData(
      id: map['id'] ?? 0,
      message: map['title'] ?? "",
      code: map['view'] ?? "",
      unitId: map['sectionid'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'code': code,
      'unitId': unitId,
    };
  }
}
