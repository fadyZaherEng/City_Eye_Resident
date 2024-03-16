import 'package:city_eye/src/core/resources/data_state.dart';
import 'package:city_eye/src/data/sources/remote/city_eye/support/request/comments_request.dart';
import 'package:city_eye/src/domain/entities/support/comments.dart';
import 'package:city_eye/src/domain/repositories/support_repository.dart';

class GetOrderCommentsUseCase {
  final SupportRepository _supportRepository;

  GetOrderCommentsUseCase(this._supportRepository);

  Future<DataState<List<Comments>>> call(
      CommentsRequest commentsRequest) async {
    return _supportRepository.getOrderComments(commentsRequest);
  }
}
