import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/users_list_screen/domain/actions/users_list_actions.dart';
import 'package:azorin_test/features/users_list_screen/domain/users_list_state.dart';

///
NestedReducerBuilder<AppState, AppStateBuilder, UsersListScreenState, UsersListScreenStateBuilder>
    createUsersListReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, UsersListScreenState, UsersListScreenStateBuilder>(
    (state) => state.usersListState,
    (builder) => builder.usersListState,
  )..add(UsersListScreenActionsNames.setUsersListScreenStatus, _setUsersListScreenStatus);
}

///
void _setUsersListScreenStatus(
    UsersListScreenState state, Action<ScreenStatusEnum> action, UsersListScreenStateBuilder builder) {
  builder.usersListScreenStatus = action.payload;
}
