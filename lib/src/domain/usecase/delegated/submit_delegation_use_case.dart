import 'dart:typed_data';

import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/submit_delegated_request.dart';
import 'package:city_eye/src/domain/entities/delegated/submit_delegation.dart';
import 'package:city_eye/src/domain/repositories/delegated_repository.dart';

class SubmitDelegationUseCase {
  final DelegatedRepository _delegatedRepository;

  SubmitDelegationUseCase(this._delegatedRepository);

  Future<DataState<SubmitDelegation>> call(
      {required String ownerIDPath,
      required String authIDPath,
      required Uint8List? ownerSignaturePath,
      required Uint8List authSignaturePath,
      required SubmitDelegatedRequest submitDelegatedRequest}) async {
    return await _delegatedRepository.submitDelegation(
      ownerIDPath,
      authIDPath,
      ownerSignaturePath,
      authSignaturePath,
      submitDelegatedRequest,
    );
  }
}
