import 'package:azorin_test/features/post_details/repository/models/_models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';

part 'post_details_actions.g.dart';

///
abstract class PostDetailsActions extends ReduxActions {
  PostDetailsActions._();

  ///
  factory PostDetailsActions() => _$PostDetailsActions();

  /// Action на запись выбранного поста в стейт окна
  late ActionDispatcher<Post> setPostDetails;

  /// Action на запись выбранного поста в стейт окна
  late ActionDispatcher<BuiltList<Comment>?> setUpdateCommentsInPostDetails;

  /// Action запроса на получение последних трех постов пользователя
  late ActionDispatcher<PostCommentsRequest> postCommentsRequest;

  /// Action ответа на запрос получение последних трех постов пользователя
  late ActionDispatcher<PostCommentsResponse> setPostCommentsResponse;

  /// Action запроса на получение последних трех альбомов пользователя
  late ActionDispatcher<AddCommentRequest> addCommentRequest;

  /// Action ответа на запрос получение последних трех альбомов пользователя
  late ActionDispatcher<AddCommentResponse> setAddCommentResponse;

  /// Action определения статуса экрана в [UserDetailsState.screenStatus].
  late ActionDispatcher<ScreenStatusEnum> setPostDetailsScreenStatus;

  ///
  late ActionDispatcher<void> clearPostDetails;
}
