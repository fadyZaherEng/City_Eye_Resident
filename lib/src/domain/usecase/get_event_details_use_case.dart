import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_details_request.dart';
import 'package:city_eye/src/domain/entities/event/event_details_data.dart';
import 'package:city_eye/src/domain/repositories/events_repository.dart';

class GetEventDetailsUseCase {
  final EventsRepository _eventsRepository;

  GetEventDetailsUseCase(this._eventsRepository);

  Future<DataState<EventDetailsData>> call(
    EventDetailsRequest eventDetailsRequest,
  ) async {
    return await _eventsRepository.getEventDetails(eventDetailsRequest);
  }
}