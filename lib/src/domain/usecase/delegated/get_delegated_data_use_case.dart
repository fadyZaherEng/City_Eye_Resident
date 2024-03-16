import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/domain/repositories/delegated_repository.dart';

class GetDelegatedDataUseCase {
  final DelegatedRepository _delegatedRepository;

  GetDelegatedDataUseCase(this._delegatedRepository);

  Future<DataState<List<Delegated>>> call() async {
    return await _delegatedRepository.getDelegatedList();
  }
}