import 'package:azorin_test/core/domain/actions/domain_actions/users_actions.dart';
import 'package:azorin_test/core/domain/global_state/app_state.dart';
import 'package:azorin_test/core/domain/global_state/domain_states/users_state.dart';
import 'package:azorin_test/core/domain/models/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';

/// Создание обработчиков действий со стейтом пользователей [UsersState].
NestedReducerBuilder<AppState, AppStateBuilder, UsersState, UsersStateBuilder> createUsersReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, UsersState, UsersStateBuilder>(
    (state) => state.usersState,
    (builder) => builder.usersState,
  )
    ..add(UsersActionsNames.setUsers, _setUsers)
    ..add(UsersActionsNames.clear, _clear);
}

/// Обработчик действия записи пользователй в стейт.
void _setUsers(UsersState state, Action<BuiltList<User>> action, UsersStateBuilder builder) {
  //
  builder.users.replace(action.payload);
}

/// Обработчик действия очистки сетйта пользователей.
void _clear(UsersState state, Action<void> action, UsersStateBuilder builder) {
  builder.users.clear();
}
