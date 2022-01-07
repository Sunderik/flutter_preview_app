import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';

///
NestedReducerBuilder<AppState, AppStateBuilder, AlbumDetailsState, AlbumDetailsStateBuilder>
    createAlbumDetailsReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, AlbumDetailsState, AlbumDetailsStateBuilder>(
    (state) => state.albumDetailsState,
    (builder) => builder.albumDetailsState,
  )
    ..add(AlbumDetailsActionsNames.setAlbumDetails, _setAlbumDetails)
    ..add(AlbumDetailsActionsNames.setUpdatePhotosInAlbumDetails, _setUpdatePhotosInAlbumDetails)
    ..add(AlbumDetailsActionsNames.setAlbumDetailsScreenStatus, _setAlbumDetailsScreenStatus)
    ..add(AlbumDetailsActionsNames.clearAlbumDetails, _clearAlbumDetails);
}

///
void _setAlbumDetails(AlbumDetailsState state, Action<Album> action, AlbumDetailsStateBuilder builder) {
  builder.album = action.payload.toBuilder();
}

///
void _setUpdatePhotosInAlbumDetails(
    AlbumDetailsState state, Action<BuiltList<AlbumPhoto>?> action, AlbumDetailsStateBuilder builder) {
  builder.album.update((b) => b..photos = action.payload!.toBuilder());
}

///
void _setAlbumDetailsScreenStatus(
    AlbumDetailsState state, Action<ScreenStatusEnum> action, AlbumDetailsStateBuilder builder) {
  builder.screenStatus = action.payload;
}

///
void _clearAlbumDetails(AlbumDetailsState state, Action<void> action, AlbumDetailsStateBuilder builder) {
  builder.album = null;
}
