import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/albums_list_screen/domain/actions/albums_list_actions.dart';
import 'package:azorin_test/features/albums_list_screen/domain/albums_list_state.dart';

///
NestedReducerBuilder<AppState, AppStateBuilder, AlbumsListScreenState, AlbumsListScreenStateBuilder>
    createAlbumsListReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, AlbumsListScreenState, AlbumsListScreenStateBuilder>(
    (state) => state.albumsListState,
    (builder) => builder.albumsListState,
  )..add(AlbumsListScreenActionsNames.setAlbumsListScreenStatus, _setAlbumsListScreenStatus);
}

///
void _setAlbumsListScreenStatus(
    AlbumsListScreenState state, Action<ScreenStatusEnum> action, AlbumsListScreenStateBuilder builder) {
  builder.albumsListScreenStatus = action.payload;
}
