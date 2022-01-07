import 'package:azorin_test/features/album_details/repository/models/album_photos_request.dart';
import 'package:azorin_test/features/album_details/repository/models/album_photos_response.dart';
import 'package:azorin_test/features/post_details/repository/models/_models.dart';
import 'package:built_collection/src/list.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';

///
MiddlewareBuilder<AppState, AppStateBuilder, AppActions> albumDetailsMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
    ..add(AlbumDetailsActionsNames.albumPhotosRequest, _albumPhotosRequest)
    ..add(AlbumDetailsActionsNames.setAlbumPhotoResponse, _setAlbumPhotoResponse);
}

///
void _albumPhotosRequest(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<AlbumPhotosRequest> action) async {
  next(action);
}

///
void _setAlbumPhotoResponse(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next,
    Action<AlbumPhotosResponse> action) async {
  next(action);

  final AlbumPhotosResponse albumPhotosResponse = action.payload;

  switch (albumPhotosResponse.httpCode) {
    case 200:
      {
        Album? album = api.state.albumDetailsState.album;
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        Album? _albumUpd = album?.rebuild((b) => b..photos = albumPhotosResponse.photos!.toBuilder());

        User? user = api.state.usersState.users.firstWhere((user) => user.id == _albumUpd!.userId);
        List<Album> _albums = user.albums!.toList();
        var _index = _albums.indexOf(album!);
        _albums.removeAt(_index);
        _albums.insert(_index, _albumUpd!);
        //переписываем полльзователя добавляя ему посты в стейте окна пользователя
        User? userUpd = user.rebuild((b) => b..albums = _albums.toBuiltList().toBuilder());
        api.actions.userScreen.setUserDetails(userUpd);

        //переписываем полльзователя добавляя ему посты в стейте пользователей
        List<User> _users = api.state.usersState.users.toList();
        var index = _users.indexOf(user);
        _users.removeAt(index);
        _users.insert(index, userUpd);
        api.actions.users.setUsers(_users.toBuiltList());
        //
        api.actions.albumDetailsScreen.setUpdatePhotosInAlbumDetails(albumPhotosResponse.photos);
        // //сохранение состояния приложения в sharedPreferences
        api.actions.saveState(null);
        break;
      }
    default:
      break;
  }
}
