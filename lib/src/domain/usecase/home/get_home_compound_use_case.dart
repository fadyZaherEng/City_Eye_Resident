import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/home/home_compound.dart';
import 'package:city_eye/src/domain/repositories/home_repository.dart';

final class GetHomeCompoundUseCase {
  final HomeRepository homeRepository;

  GetHomeCompoundUseCase(this.homeRepository);

  Future<DataState<HomeCompound>> call() async =>
      await homeRepository.getHomeCompound();
}
