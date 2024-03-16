import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/send_comment_request.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

class SendOrderCommentUseCase {
  final SupportRepository _supportRepository;

  SendOrderCommentUseCase(this._supportRepository);

  Future<DataState<List<Comments>>> call(
      String imagePath, SendCommentRequest sendCommentRequest) async {
    return _supportRepository.sendSupportComment(
      imagePath,
      sendCommentRequest,
    );
  }
}
