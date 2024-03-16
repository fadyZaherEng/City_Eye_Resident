import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_identity.dart';
import 'package:city_eye/src/domain/repositories/badge_identity_repository.dart';

class GetBadgeIdentityUseCase {
final BadgeIdentityRepository _badgeIdentityRepository;

  GetBadgeIdentityUseCase(this._badgeIdentityRepository);

  Future<DataState<BadgeIdentity>> call() async {
    return await _badgeIdentityRepository.getBadgeIdentity();
  }
}