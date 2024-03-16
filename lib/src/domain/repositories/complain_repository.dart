import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/complain/request/submit_complain_request.dart';
import 'package:city_eye/src/domain/entities/complain/complain.dart';

abstract class ComplainRepository {
  Future<DataState<Complain>> submitComplain(
    String audioPath,
    String videoPath,
    List<String> imagesPath,
    SubmitComplainRequest submitComplainRequest,
  );
}
