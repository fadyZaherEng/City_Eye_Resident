import 'dart:typed_data';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delete_delegated_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/submit_delegated_request.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/domain/entities/delegated/submit_delegation.dart';

abstract class DelegatedRepository {
  Future<DataState<List<Delegated>>> getDelegatedList();

  Future<DataState> deleteDelegated(
      DeleteDelegatedRequest deleteDelegatedRequest);

  Future<DataState<SubmitDelegation>> submitDelegation(
    String ownerIDPath,
    String authIDPath,
    Uint8List? ownerSignaturePath,
    Uint8List? authSignaturePath,
    SubmitDelegatedRequest submitDelegatedRequest,
  );
}
