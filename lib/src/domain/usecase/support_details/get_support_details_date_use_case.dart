import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/support_details_date_request.dart';
import 'package:city_eye/src/domain/entities/support_details/prepared_visit_time.dart';
import 'package:city_eye/src/domain/entities/support_details/support_details_date.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

final class GetSupportDetailsDateUseCase {
  final SupportRepository _supportDetailsRepository;

  GetSupportDetailsDateUseCase(this._supportDetailsRepository);

  Future<DataState<SupportDetailsDate>> call(
          SupportDetailsDateRequest supportDetailsDateRequest) async =>
      await _supportDetailsRepository
          .getSupportDetailsDate(supportDetailsDateRequest);
}
