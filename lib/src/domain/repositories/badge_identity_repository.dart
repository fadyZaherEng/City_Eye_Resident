import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/badge_identity/badge_identity.dart';

abstract class BadgeIdentityRepository {
  Future<DataState<BadgeIdentity>> getBadgeIdentity();
}
