import 'package:azorin_test/features/album_details/repository/models/_models.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';

part 'album_details_actions.g.dart';

///
abstract class AlbumDetailsActions extends ReduxActions {
  AlbumDetailsActions._();

  ///
  factory AlbumDetailsActions() => _$AlbumDetailsActions();

  ///
  late ActionDispatcher<Album> setAlbumDetails;

  ///
  late ActionDispatcher<BuiltList<AlbumPhoto>?> setUpdatePhotosInAlbumDetails;

  ///
  late ActionDispatcher<AlbumPhotosRequest> albumPhotosRequest;

  ///
  late ActionDispatcher<AlbumPhotosResponse> setAlbumPhotoResponse;

  ///
  late ActionDispatcher<ScreenStatusEnum> setAlbumDetailsScreenStatus;

  ///
  late ActionDispatcher<void> clearAlbumDetails;
}
