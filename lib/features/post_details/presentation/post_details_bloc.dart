import 'dart:async';

import 'package:azorin_test/core/bloc/base_bloc.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/domain/models/post.dart';
import 'package:azorin_test/features/post_details/repository/models/_models.dart';
import 'package:built_collection/built_collection.dart';

///
class PostDetailsBloc extends BaseBloc {
  PostDetailsBloc(this.postId);

  ///
  final int postId;

  ///
  Post? post;

  late String? userEmail;

  /// Поток данных контроллера [_postDetailsScreenStatusController].
  Stream<ScreenStatusEnum?>? get postDetailsScreenStatusStream => _postDetailsScreenStatusController?.stream;

  /// Контроллер статуса экрана.
  late StreamController<ScreenStatusEnum?>? _postDetailsScreenStatusController;

  /// Подписка на значения поля [PostDetailsState.screenStatus].
  late StreamSubscription<ScreenStatusEnum?>? _postDetailsScreenStatusSubscription;

  /// Поток данных контроллера [_commentsController].
  Stream<List<Comment>?>? get commentsStream => _commentsController?.stream;

  /// Контроллер списка постов пользователя.
  late StreamController<List<Comment>?>? _commentsController;

  /// Подписка на значения поля
  late StreamSubscription<BuiltList<Comment>?>? _commentsSubscription;

  ///
  Post? getPostDetails() {
    return post;
  }

  ///  .
  void clearPostDetails() {
    actions.postDetailsScreen.clearPostDetails(null);
  }

  @override
  void init() {
    super.init();
    _postDetailsScreenStatusSubscription = store
        ?.nextSubstate((AppState state) => state.postDetailsState.screenStatus)
        .listen((ScreenStatusEnum? screenStatus) {
      if (screenStatus != null) {
        _postDetailsScreenStatusController?.sink.add(screenStatus);
      }
    });
    _postDetailsScreenStatusController = StreamController<ScreenStatusEnum>.broadcast();

    _commentsSubscription = store
        ?.nextSubstate((AppState state) => state.postDetailsState.post?.comments)
        .listen((BuiltList<Comment>? comments) {
      if (comments != null) {
        _commentsController?.sink.add(comments.toList());
      }
    });
    _commentsController = StreamController<List<Comment>?>.broadcast();

    userEmail = store?.state.userDetailsState.user?.email;
  }

  ///
  void loadPostInfo() {
    post = store!.state.userDetailsState.user!.posts!.firstWhere((_post) => _post.id == postId);

    Future.delayed(const Duration(microseconds: 1)) //для разделения инциализирующего потока (чтоб инит не перекрывал)
        .then((value) => {
              if (post != null)
                {
                  store!.actions.postDetailsScreen.setPostDetails(post!),
                  _postDetailsScreenStatusController?.sink.add(ScreenStatusEnum.wait),
                }
              else
                {
                  _postDetailsScreenStatusController?.sink.add(ScreenStatusEnum.loading),
                }
            });
  }

  @override
  void dispose() {
    _postDetailsScreenStatusController?.close();
    _postDetailsScreenStatusSubscription?.cancel();
    _commentsController?.close();
    _commentsSubscription?.cancel();
    super.dispose();
  }

  ///
  loadPostComments() {
    var _comments = post!.comments?.toList();
    if (_comments != null && _comments.isNotEmpty) {
      _commentsController?.sink.add(_comments);
    } else {
      _downloadPostComments();
    }
  }

  ///
  _downloadPostComments() {
    final request = PostCommentsRequest((builder) => builder..postId = postId);
    // Выполяем запрос.
    store?.actions.postDetailsScreen.postCommentsRequest(request);
    store?.actions.postDetailsScreen.setPostDetailsScreenStatus(ScreenStatusEnum.loading);
  }

  ///
  addComment(String name, String body, String email) {
    final request = AddCommentRequest((builder) => builder
      ..postId = postId
      ..email = email
      ..name = name
      ..body = body);
    store?.actions.postDetailsScreen.addCommentRequest(request);
  }

}
