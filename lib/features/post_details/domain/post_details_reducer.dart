import 'package:azorin_test/features/post_details/domain/domain.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';

///
NestedReducerBuilder<AppState, AppStateBuilder, PostDetailsState, PostDetailsStateBuilder> createPostDetailsReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, PostDetailsState, PostDetailsStateBuilder>(
    (state) => state.postDetailsState,
    (builder) => builder.postDetailsState,
  )
    ..add(PostDetailsActionsNames.setPostDetails, _setPostDetails)
    ..add(PostDetailsActionsNames.setUpdateCommentsInPostDetails, _setUpdateCommentsInPostDetails)
    ..add(PostDetailsActionsNames.setPostDetailsScreenStatus, _setPostDetailsScreenStatus)
    ..add(PostDetailsActionsNames.clearPostDetails, _clearPostDetails);
}

///
void _setPostDetails(PostDetailsState state, Action<Post> action, PostDetailsStateBuilder builder) {
  builder.post = action.payload.toBuilder();
}

///
void _setUpdateCommentsInPostDetails(
    PostDetailsState state, Action<BuiltList<Comment>?> action, PostDetailsStateBuilder builder) {
  builder.post.update((b) => b..comments = action.payload!.toBuilder());
}

///
void _setPostDetailsScreenStatus(
    PostDetailsState state, Action<ScreenStatusEnum> action, PostDetailsStateBuilder builder) {
  builder.screenStatus = action.payload;
}

///
void _clearPostDetails(PostDetailsState state, Action<void> action, PostDetailsStateBuilder builder) {
  builder.post = null;
}
