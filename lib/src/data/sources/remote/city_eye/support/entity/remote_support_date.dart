import 'package:city_eye/src/domain/entities/support_details/prepared_visit_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_support_date.g.dart';

@JsonSerializable()
final class RemoteSupportDate {
  final int? id;
  final String? name;
  @JsonKey(name: 'time')
  final String? date;

  const RemoteSupportDate({
    this.id = 0,
    this.name = '',
    this.date = '',
  });

  factory RemoteSupportDate.fromJson(Map<String, dynamic> json) =>
      _$RemoteSupportDateFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteSupportDateToJson(this);
}

extension RemoteSupportDateExtension on RemoteSupportDate {
  PreparedVisitTime mapToDomain() {
    return PreparedVisitTime(
      id: id ?? 0,
      name: name ?? "",
      date: date ?? "",
    );
  }
}

extension RemoteSupportDateListExtension on List<RemoteSupportDate>? {
  List<PreparedVisitTime> mapToDomain() {
    return this!.map((date) => date.mapToDomain()).toList();
  }
}
