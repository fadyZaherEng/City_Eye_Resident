import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/delegated/request/delete_delegated_request.dart';
import 'package:city_eye/src/domain/repositories/delegated_repository.dart';

class DeleteDelegatedUseCase {
  final DelegatedRepository _delegatedRepository;

  DeleteDelegatedUseCase(this._delegatedRepository);

  Future<DataState> call(DeleteDelegatedRequest deleteDelegatedRequest) async {
    return await _delegatedRepository.deleteDelegated(deleteDelegatedRequest);
  }
}