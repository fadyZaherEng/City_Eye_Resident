import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';
import 'package:city_eye/src/domain/repositories/events_repository.dart';

class SubmitEventUseCase {
  final EventsRepository _eventsRepository;

  const SubmitEventUseCase(this._eventsRepository);

  Future<DataState<SubmitEvent>> call(SubmitEventRequest request) async {
    return await _eventsRepository.submitEvent(request);
  }
}
