import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/user_details_screen/domain/domain.dart';
import 'package:azorin_test/features/user_details_screen/repository/models/_models.dart';

///
MiddlewareBuilder<AppState, AppStateBuilder, AppActions> userDetailsMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add(UserDetailsActionsNames.userPostsRequest, _userPostsRequest)
    ..add(UserDetailsActionsNames.setUserPostsResponse, _setUserPostsResponse)
    ..add(UserDetailsActionsNames.userAlbumsRequest, _userAlbumsRequest)
    ..add(UserDetailsActionsNames.setUserAlbumsResponse, _setUserAlbumsResponse);
}

/// Запрос на получение информации об исполнителе.
void _userPostsRequest(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<UserPostsRequest> action) async {
  next(action);
}

/// Ответ на запрос изменения статуса пользователя.
void _setUserPostsResponse(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<UserPostsResponse> action) async {
  next(action);

  final UserPostsResponse userPostsResponse = action.payload;

  switch (userPostsResponse.httpCode) {
    case 200:
      {
        User? user = api.state.userDetailsState.user;
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        User? userUpd = user?.rebuild((b) => b..posts = userPostsResponse.posts!.toBuilder());
        api.actions.userScreen.setUserDetails(userUpd!);
        //переписываем полльзователя добавляя ему посты в стейте пользователей
        List<User> _users = api.state.usersState.users.toList();
        var index = _users.indexOf(user!);
        _users.removeAt(index);
        _users.insert(index, userUpd);
        api.actions.users.setUsers(_users.toBuiltList());
        //сохранение состояния приложения в sharedPreferences
        api.actions.saveState(null);
        break;
      }
    default:
      break;
  }
}

/// Запрос на изменение статуса пользователя.
void _userAlbumsRequest(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<UserAlbumsRequest> action) async {
  next(action);
}

/// Ответ на запрос получения информации о сотруднике.
void _setUserAlbumsResponse(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<UserAlbumsResponse> action) async {
  next(action);

  final UserAlbumsResponse userAlbumsResponse = action.payload;
  switch (userAlbumsResponse.httpCode) {
    case 200:
      {
        User? user = api.state.userDetailsState.user;
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        User? userUpd = user?.rebuild((b) => b..albums = userAlbumsResponse.albums!.toBuilder());
        api.actions.userScreen.setUserDetails(userUpd!);
        //переписываем полльзователя добавляя ему посты в стейте пользователей
        List<User> _users = api.state.usersState.users.toList();
        var index = _users.indexOf(user!);
        _users.removeAt(index);
        _users.insert(index, userUpd);
        api.actions.users.setUsers(_users.toBuiltList()); //сохранение состояния приложения в sharedPreferences
        api.actions.saveState(null);
        break;
      }
    default:
      break;
  }
}
