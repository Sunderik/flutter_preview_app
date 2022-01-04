import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/posts_list_screen/domain/actions/posts_list_actions.dart';
import 'package:azorin_test/features/posts_list_screen/domain/posts_list_state.dart';

///
NestedReducerBuilder<AppState, AppStateBuilder, PostsListScreenState, PostsListScreenStateBuilder>
    createPostsListReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, PostsListScreenState, PostsListScreenStateBuilder>(
    (state) => state.postsListState,
    (builder) => builder.postsListState,
  )..add(PostsListScreenActionsNames.setPostsListScreenStatus, _setPostsListScreenStatus);
}

///
void _setPostsListScreenStatus(
    PostsListScreenState state, Action<ScreenStatusEnum> action, PostsListScreenStateBuilder builder) {
  builder.postsListScreenStatus = action.payload;
}
