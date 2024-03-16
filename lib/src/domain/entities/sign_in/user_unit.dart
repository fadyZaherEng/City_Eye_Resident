import 'package:city_eye/src/domain/entities/sign_in/user_unit_parent.dart';
import 'package:equatable/equatable.dart';

class UserUnit extends Equatable {
  //         "id": 653,
  //         "compoundId": 1,
  //         "compoundName": "Palm Hills Katameya",
  //         "unitId": 20,
  //         "unitNo": "1004",
  //         "unitName": "A 4",
  //         "compoundLogo": "http://108.181.167.130:8765/CityEye_API_Test_New/Attachments/Compound/Logo/1/d7700e7c-788a-43ac-9fd5-4fb0cea7c161.jpg",
  //         "address": "نادي الزهور القاهرة الجديدة",
  //         "isActive": true,
  //         "userTypeId": 2,
  //         "userTypeName": "Tenant",
  //         "userUnitContractEndDate": "2025-01-16T16:29:50.6452255",
  //         "isCompoundVerified": true,
  //         "lastMassage": null,
  //         "parents": null
  final int compoundId;
  final String compoundName;
  final int unitId;
  final String unitNo;
  final String unitName;
  final String compoundLogo;
  final String address;
  final bool isActive;
  final int userTypeId;
  final String userTypeName;
  final String userUnitContractEndDate;
  final bool isSelected;
  final bool isCompoundVerified;
  final String message;
  final List<UserUnitParent> parents;

  const UserUnit({
    this.compoundId = 0,
    this.compoundName = "",
    this.unitId = 0,
    this.unitNo = "",
    this.unitName = "",
    this.compoundLogo = "",
    this.address = "",
    this.isActive = false,
    this.userTypeId = 0,
    this.userTypeName = "",
    this.userUnitContractEndDate = "",
    this.isSelected = false,
    this.isCompoundVerified = false,
    this.message = "",
    this.parents = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'compoundId': compoundId,
      'compoundName': compoundName,
      'unitId': unitId,
      'unitNo': unitNo,
      'unitName': unitName,
      'compoundLogo': compoundLogo,
      'address': address,
      'isActive': isActive,
      'userTypeId': userTypeId,
      'userTypeName': userTypeName,
      'userUnitContractEndDate': userUnitContractEndDate,
      'isSelected': isSelected,
      'isCompoundVerified': isCompoundVerified,
      'message': message,
      'parents': parents.map((element) => element.toMap()).toList(),
    };
  }

  factory UserUnit.fromMap(Map<String, dynamic> map) {
    return UserUnit(
      compoundId: map['compoundId'],
      compoundName: map['compoundName'],
      unitId: map['unitId'],
      unitNo: map['unitNo'],
      unitName: map['unitName'],
      compoundLogo: map['compoundLogo'],
      address: map['address'],
      isActive: map['isActive'],
      userTypeId: map['userTypeId'],
      userTypeName: map['userTypeName'],
      userUnitContractEndDate: map['userUnitContractEndDate'],
      isSelected: map['isSelected'],
      isCompoundVerified: map['isCompoundVerified'],
      message: map['message'],
      parents: List<UserUnitParent>.from(
          map['parents'].map((x) => UserUnitParent.fromMap(x))),
    );
  }

  UserUnit copyWith({
    int? compoundId,
    String? compoundName,
    int? unitId,
    String? unitNo,
    String? unitName,
    String? compoundLogo,
    String? address,
    bool? isActive,
    int? userTypeId,
    String? userTypeName,
    String? userUnitContractEndDate,
    String? message,
    bool? isSelected,
    bool? isCompoundVerified,
    List<UserUnitParent>? parents,
  }) {
    return UserUnit(
      compoundId: compoundId ?? this.compoundId,
      compoundName: compoundName ?? this.compoundName,
      unitId: unitId ?? this.unitId,
      unitNo: unitNo ?? this.unitNo,
      unitName: unitName ?? this.unitName,
      compoundLogo: compoundLogo ?? this.compoundLogo,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      userTypeId: userTypeId ?? this.userTypeId,
      userTypeName: userTypeName ?? this.userTypeName,
      message: message ?? this.message,
      parents: parents ?? this.parents,
      userUnitContractEndDate:
          userUnitContractEndDate ?? this.userUnitContractEndDate,
      isSelected: isSelected ?? this.isSelected,
      isCompoundVerified: isCompoundVerified ?? this.isCompoundVerified,
    );
  }

  @override
  List<Object> get props => [
        compoundId,
        compoundName,
        unitId,
        unitNo,
        unitName,
        compoundLogo,
        address,
        isActive,
        userTypeId,
        userTypeName,
        userUnitContractEndDate,
        isSelected,
        isCompoundVerified,
        parents,
        message,
      ];
}
