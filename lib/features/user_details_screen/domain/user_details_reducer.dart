import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/user_details_screen/domain/domain.dart';

///
NestedReducerBuilder<AppState, AppStateBuilder, UserDetailsState, UserDetailsStateBuilder> createUserDetailsReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, UserDetailsState, UserDetailsStateBuilder>(
    (state) => state.userDetailsState,
    (builder) => builder.userDetailsState,
  )
    ..add(UserDetailsActionsNames.setUserDetails, _setUserDetails)
    ..add(UserDetailsActionsNames.setUserDetailsScreenStatus, _setUserDetailsScreenStatus)
    ..add(UserDetailsActionsNames.clearUserDetails, _clearUserDetails);
}

///
void _setUserDetails(UserDetailsState state, Action<User> action, UserDetailsStateBuilder builder) {
  builder.user = action.payload.toBuilder();
}

///
void _setUserDetailsScreenStatus(
    UserDetailsState state, Action<ScreenStatusEnum> action, UserDetailsStateBuilder builder) {
  builder.screenStatus = action.payload;
}

///
void _clearUserDetails(UserDetailsState state, Action<void> action, UserDetailsStateBuilder builder) {
  builder.user = null;
}
