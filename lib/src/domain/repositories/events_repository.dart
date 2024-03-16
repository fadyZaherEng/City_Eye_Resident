import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/domain/entities/event/event_data.dart';
import 'package:city_eye/src/domain/entities/event/event_details_data.dart';
import 'package:city_eye/src/domain/entities/event/submit_event.dart';

abstract class EventsRepository {
  Future<DataState<EventData>> getEvents();

  Future<DataState<SubmitEvent>> submitEvent(
    SubmitEventRequest submitEventRequest,
  );

  Future<DataState<EventDetailsData>> getEventDetails(
    EventDetailsRequest eventDetailsRequest,
  );
}
