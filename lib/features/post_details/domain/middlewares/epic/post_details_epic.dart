import 'dart:async';

import 'package:azorin_test/features/post_details/repository/models/_models.dart';
import 'package:azorin_test/features/post_details/repository/post_details_repository.dart';
import 'package:built_redux/built_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/library/logger/logger.dart';


///
@Injectable()
class PostDetailsEpic {
  PostDetailsEpic(this._repository);

  ///
  final PostDetailsRepository _repository;

  ///
  Stream postCommentsEpic(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((action) => action.name == PostDetailsActionsNames.postCommentsRequest.name)
        .cast<Action<PostCommentsRequest>>()
        .switchMap((action) {
      final request = action.payload;
      return _repository.makePostCommentsRequest(
        postId: request.postId,
        timeout: const Duration(seconds: 20),
      );
    }).doOnData((postCommentsResponse) {
      logger.i('Received Response Body: \n$postCommentsResponse');
      api.actions.postDetailsScreen.setPostCommentsResponse(postCommentsResponse);
    }).handleError((exception) {
      logger.e(exception);
    });
  }

  ///
  Stream addCommentEpic(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((action) => action.name == PostDetailsActionsNames.addCommentRequest.name)
        .cast<Action<AddCommentRequest>>()
        .switchMap((action) {
      final request = action.payload;
      return _repository.makeAddCommentRequest(
        request: request,
        timeout: const Duration(seconds: 20),
      );
    }).doOnData((addCommentResponse) {
      logger.i('Received Response Body: \n$addCommentResponse');
      api.actions.postDetailsScreen.setAddCommentResponse(addCommentResponse);
    }).handleError((exception) {
      logger.e(exception);
    });
  }
}
