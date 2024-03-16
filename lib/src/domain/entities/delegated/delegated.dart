import 'package:city_eye/src/domain/entities/settings/page_field.dart';
import 'package:equatable/equatable.dart';

class Delegated extends Equatable {
  final int id;
  final String notes;
  final String name;
  final String personalID;
  final String ownerIDAttachment;
  final String fromDate;
  final String toDate;
  final String authName;
  final String authPersonalID;
  final String authMobile;
  final String authIDAttachment;
  final int statusId;
  final String ownerSignatureAttachment;
  final String authSignatureAttachment;
  final List<PageField> ownerExtraField;
  final List<PageField> authExtraField;
  final bool isEnabled;
  final String authCountryCode;
  final String qrImage;
  final String documentDelegation;
  final int pinCode;

  const Delegated({
    this.id = 0,
    this.notes = "",
    this.name = "",
    this.personalID = "",
    this.ownerIDAttachment = "",
    this.fromDate = "",
    this.toDate = "",
    this.authName = "",
    this.authPersonalID = "",
    this.authMobile = "",
    this.authIDAttachment = "",
    this.statusId = 1,
    this.ownerSignatureAttachment = "",
    this.authSignatureAttachment = "",
    this.ownerExtraField = const [],
    this.authExtraField = const [],
    this.isEnabled = false,
    this.authCountryCode = "EG",
    this.qrImage = "",
    this.documentDelegation = "",
    this.pinCode = 0,
  });

  Delegated deepClone() {
    return Delegated(
      id: id,
      notes: notes,
      name: name,
      personalID: personalID,
      ownerIDAttachment: ownerIDAttachment,
      fromDate: fromDate,
      toDate: toDate,
      authName: authName,
      authPersonalID: authPersonalID,
      authMobile: authMobile,
      authIDAttachment: authIDAttachment,
      statusId: statusId,
      ownerSignatureAttachment: ownerSignatureAttachment,
      authSignatureAttachment: authSignatureAttachment,
      ownerExtraField:
          ownerExtraField.map((choice) => choice.deepClone()).toList(),
      authExtraField:
          authExtraField.map((choice) => choice.deepClone()).toList(),
      isEnabled: isEnabled,
      authCountryCode: authCountryCode,
      qrImage: qrImage,
      documentDelegation: documentDelegation,
      pinCode: pinCode,
    );
  }

  Delegated copyWith({
    int? id,
    String? notes,
    String? name,
    String? personalID,
    String? ownerIDAttachment,
    String? fromDate,
    String? toDate,
    String? authName,
    String? authPersonalID,
    String? authMobile,
    String? authIDAttachment,
    int? statusId,
    String? ownerSignatureAttachment,
    String? authSignatureAttachment,
    List<PageField>? ownerExtraField,
    List<PageField>? authExtraField,
    bool? isEnabled,
    String? authCountryCode,
    String? qrImage,
    String? documentDelegation,
    int? pinCode,
  }) {
    return Delegated(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      name: name ?? this.name,
      personalID: personalID ?? this.personalID,
      ownerIDAttachment: ownerIDAttachment ?? this.ownerIDAttachment,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      authName: authName ?? this.authName,
      authPersonalID: authPersonalID ?? this.authPersonalID,
      authMobile: authMobile ?? this.authMobile,
      authIDAttachment: authIDAttachment ?? this.authIDAttachment,
      statusId: statusId ?? this.statusId,
      ownerSignatureAttachment:
          ownerSignatureAttachment ?? this.ownerSignatureAttachment,
      authSignatureAttachment:
          authSignatureAttachment ?? this.authSignatureAttachment,
      ownerExtraField: ownerExtraField ?? this.ownerExtraField,
      authExtraField: authExtraField ?? this.authExtraField,
      isEnabled: isEnabled ?? this.isEnabled,
      authCountryCode: authCountryCode ?? this.authCountryCode,
      qrImage: qrImage ?? this.qrImage,
      documentDelegation: documentDelegation ?? this.documentDelegation,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        notes,
        name,
        personalID,
        ownerIDAttachment,
        fromDate,
        toDate,
        authName,
        authPersonalID,
        authMobile,
        authIDAttachment,
        statusId,
        ownerSignatureAttachment,
        authSignatureAttachment,
        ownerExtraField,
        authExtraField,
        isEnabled,
        authCountryCode,
        qrImage,
        documentDelegation,
        pinCode,
      ];
}
