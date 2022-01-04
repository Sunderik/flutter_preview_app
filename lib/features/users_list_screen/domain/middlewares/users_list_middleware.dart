import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/users_list_screen/domain/actions/users_list_actions.dart';
import 'package:azorin_test/features/users_list_screen/repository/models/_models.dart';

///
MiddlewareBuilder<AppState, AppStateBuilder, AppActions> usersListMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add(UsersListScreenActionsNames.usersRequest, _usersRequest)
    ..add(UsersListScreenActionsNames.setUsersResponse, _setUsersResponse);
}

/// Запрос поулчения исполнителей.
void _usersRequest(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, next, Action<void> action) async {
  next(action);
}

/// Ответ на запрос получения исполнителей.
void _setUsersResponse(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, next, Action<UsersResponse> action) {
  next(action);

  UsersResponse usersResponse = action.payload;

  switch (usersResponse.httpCode) {
    case 200:
      {
        api.actions.usersScreen.setUsersListScreenStatus(ScreenStatusEnum.wait);
        api.actions.users.setUsers(usersResponse.users!.toBuiltList());
        //сохранение состояния приложения в sharedPreferences
        api.actions.saveState(null);
        break;
      }
    default:
      break;
  }
}
