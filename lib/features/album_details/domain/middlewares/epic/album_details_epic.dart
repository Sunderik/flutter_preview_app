import 'dart:async';

import 'package:azorin_test/features/album_details/repository/album_details_repository.dart';
import 'package:azorin_test/features/album_details/repository/models/_models.dart';
import 'package:built_redux/built_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/library/logger/logger.dart';

///
@Injectable()
class AlbumDetailsEpic {
  AlbumDetailsEpic(this._repository);

  ///
  final AlbumDetailsRepository _repository;

  ///
  Stream albumPhotosEpic(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((action) => action.name == AlbumDetailsActionsNames.albumPhotosRequest.name)
        .cast<Action<AlbumPhotosRequest>>()
        .switchMap((action) {
      final request = action.payload;
      return _repository.makeAlbumPhotosRequest(
        albumId: request.albumId,
        timeout: const Duration(seconds: 20),
      );
    }).doOnData((albumPhotosResponse) {
      logger.i('Received Response Body: \n$albumPhotosResponse');
      api.actions.albumDetailsScreen.setAlbumPhotoResponse(albumPhotosResponse);
    }).handleError((exception) {
      logger.e(exception);
    });
  }
}
