import 'package:city_eye/src/data/sources/remote/city_eye/settings/entity/remote_page_field.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_delegated.g.dart';

@JsonSerializable()
class RemoteDelegated {
  final int? id;
  final String? notes;
  final String? name;
  final String? personalID;
  final String? ownerIDAttachment;
  final String? fromDate;
  final String? toDate;
  final String? authName;
  final String? authPersonalID;
  final String? authMobile;
  final String? authIDAttachment;
  final int? statusId;
  final String? ownerSignatureAttachment;
  final String? authSignatureAttachment;
  final String? authCountryCode;
  final String? qrImage;
  final String? documentDelegation;
  final int? pinCode;
  final List<RemotePageField>? ownerExtraField;
  final List<RemotePageField>? authExtraField;
  final bool? isEnabled;

  const RemoteDelegated({
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
    this.statusId = 0,
    this.ownerSignatureAttachment = "",
    this.authSignatureAttachment = "",
    this.authCountryCode = "EG",
    this.isEnabled = false,
    this.ownerExtraField = const [],
    this.authExtraField = const [],
    this.qrImage = "",
    this.documentDelegation = "",
    this.pinCode = 0,
  });

  factory RemoteDelegated.fromJson(Map<String, dynamic> json) =>
      _$RemoteDelegatedFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteDelegatedToJson(this);
}

extension RemoteDelegatedExtension on RemoteDelegated {
  Delegated mapToDomain() {
    return Delegated(
      id: id ?? 0,
      notes: notes ?? "",
      name: name ?? "",
      personalID: personalID ?? "",
      ownerIDAttachment: ownerIDAttachment ?? "",
      fromDate: fromDate ?? "",
      toDate: toDate ?? "",
      authName: authName ?? "",
      authPersonalID: authPersonalID ?? "",
      authMobile: authMobile ?? "",
      authIDAttachment: authIDAttachment ?? "",
      statusId: statusId ?? 0,
      ownerSignatureAttachment: ownerSignatureAttachment ?? "",
      authSignatureAttachment: authSignatureAttachment ?? "",
      ownerExtraField: ownerExtraField.mapToDomain(),
      authExtraField: authExtraField.mapToDomain(),
      isEnabled: isEnabled ?? false,
      authCountryCode: authCountryCode ?? "EG",
      qrImage: qrImage ?? "",
      documentDelegation: documentDelegation ?? "",
      pinCode: pinCode ?? 0,
    );
  }
}

extension RemoteDelegatedListExtension on List<RemoteDelegated>? {
  List<Delegated> mapToDomain() {
    return this?.map((e) => e.mapToDomain()).toList() ?? [];
  }
}
