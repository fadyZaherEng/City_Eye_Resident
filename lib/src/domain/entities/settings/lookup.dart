import 'package:city_eye/src/domain/entities/settings/lookup_file.dart';
import 'package:equatable/equatable.dart';

class Lookup extends Equatable {
  final String lookupCode;
  final List<LookupFile> files;

  const Lookup({
    this.lookupCode = "",
    this.files = const [],
  });

  @override
  List<Object?> get props => [
        lookupCode,
        files,
      ];
}
