import 'package:azorin_test/features/post_details/repository/models/_models.dart';
import 'package:built_collection/src/list.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';

///
MiddlewareBuilder<AppState, AppStateBuilder, AppActions> postDetailsMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add(PostDetailsActionsNames.postCommentsRequest, _postCommentsRequest)
    ..add(PostDetailsActionsNames.setPostCommentsResponse, _setPostCommentsResponse)
    ..add(PostDetailsActionsNames.addCommentRequest, _addCommentRequest)
    ..add(PostDetailsActionsNames.setAddCommentResponse, _setAddCommentResponse);
}

///
void _postCommentsRequest(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<PostCommentsRequest> action) async {
  next(action);
}

///
void _setPostCommentsResponse(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<PostCommentsResponse> action) async {
  next(action);

  final PostCommentsResponse postCommentsResponse = action.payload;

  switch (postCommentsResponse.httpCode) {
    case 200:
      {
        Post? post = api.state.postDetailsState.post;
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        Post? _postUpd = post?.rebuild((b) => b..comments = postCommentsResponse.comments!.toBuilder());

        User? user = api.state.usersState.users.firstWhere((user) => user.id == _postUpd!.userId);
        List<Post> _posts = user.posts!.toList();
        var _index = _posts.indexOf(post!);
        _posts.removeAt(_index);
        _posts.insert(_index, _postUpd!);
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        User? userUpd = user.rebuild((b) => b..posts = _posts.toBuiltList().toBuilder());
        api.actions.userScreen.setUserDetails(userUpd);

        //переписываем полльзователя добавляя ему посты в стейте пользователей
        List<User> _users = api.state.usersState.users.toList();
        var index = _users.indexOf(user);
        _users.removeAt(index);
        _users.insert(index, userUpd);
        api.actions.users.setUsers(_users.toBuiltList());
        //
        api.actions.postDetailsScreen.setUpdateCommentsInPostDetails(postCommentsResponse.comments);
        // //сохранение состояния приложения в sharedPreferences
        api.actions.saveState(null);
        break;
      }
    default:
      break;
  }
}

///
void _addCommentRequest(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<AddCommentRequest> action) async {
  next(action);
}

///
void _setAddCommentResponse(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<AddCommentResponse> action) async {
  next(action);

  final AddCommentResponse addCommentResponse = action.payload;
  switch (addCommentResponse.httpCode) {
    case 201:
      {
        Post? post = api.state.postDetailsState.post;
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        Post? _postUpd = post?.rebuild((b) => b..comments.add(addCommentResponse.comment!));

        User? user = api.state.usersState.users.firstWhere((user) => user.id == _postUpd!.userId);
        List<Post> _posts = user.posts!.toList();
        var _index = _posts.indexOf(post!);
        _posts.removeAt(_index);
        _posts.insert(_index, _postUpd!);
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        User? userUpd = user.rebuild((b) => b..posts = _posts.toBuiltList().toBuilder());
        api.actions.userScreen.setUserDetails(userUpd);

        //переписываем полльзователя добавляя ему посты в стейте пользователей
        List<User> _users = api.state.usersState.users.toList();
        var index = _users.indexOf(user);
        _users.removeAt(index);
        _users.insert(index, userUpd);
        api.actions.users.setUsers(_users.toBuiltList());
        //
        api.actions.postDetailsScreen.setUpdateCommentsInPostDetails(_postUpd.comments);
        // //сохранение состояния приложения в sharedPreferences
        api.actions.saveState(null);
        break;
      }
    default:
      break;
  }
}
