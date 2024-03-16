import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/repositories/events_repository.dart';

class GetEventsUseCase {
  final EventsRepository _eventsRepository;

  GetEventsUseCase(this._eventsRepository);

  Future<DataState<EventData>> call() async {
    return await _eventsRepository.getEvents();
  }
}
