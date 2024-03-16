import 'package:city_eye/src/data/sources/remote/api_key.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/city_eye_response.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/entity/remote_event_data.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/entity/remote_event_details_data.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/entity/remote_submit_event.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/event_details_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/events/request/submit_event_request.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/home/entity/remote_extra_field.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'events_api_services.g.dart';

@RestApi()
abstract class EventsAPIServices {
  factory EventsAPIServices(Dio dio) = _EventsAPIServices;

  @POST(APIKeys.getEventList)
  Future<HttpResponse<CityEyeResponse<RemoteEventData>>> getEvents(
      @Body() CityEyeRequest request);

  @POST(APIKeys.eventDetails)
  Future<HttpResponse<CityEyeResponse<RemoteEventDetailsData>>> getEventDetails(
      @Body() CityEyeRequest<EventDetailsRequest> request);

  @POST(APIKeys.submitEvent)
  @MultiPart()
  Future<HttpResponse<CityEyeResponse<RemoteSubmitEvent>>> submitEvent(
      @Part(name: 'requestHeader') String requestHeader,
      @Part(name: "Files") List<MultipartFile> files,
  );
}
