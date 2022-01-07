import 'dart:async';

import 'package:azorin_test/core/bloc/base_bloc.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/domain/models/album.dart';
import 'package:azorin_test/features/album_details/repository/models/_models.dart';
import 'package:built_collection/built_collection.dart';

///
class AlbumDetailsBloc extends BaseBloc {
  AlbumDetailsBloc(this.albumId);

  ///
  final int albumId;

  ///
  Album? _album;

  /// Поток данных контроллера [_albumDetailsScreenStatusController].
  Stream<ScreenStatusEnum?>? get albumDetailsScreenStatusStream => _albumDetailsScreenStatusController?.stream;

  /// Контроллер статуса экрана.
  late StreamController<ScreenStatusEnum?>? _albumDetailsScreenStatusController;

  /// Подписка на значения поля [AlbumDetailsState.screenStatus].
  late StreamSubscription<ScreenStatusEnum?>? _albumDetailsScreenStatusSubscription;

  /// Поток данных контроллера [_photosController].
  Stream<List<AlbumPhoto>?>? get photosStream => _photosController?.stream;

  /// Контроллер списка постов пользователя.
  late StreamController<List<AlbumPhoto>?>? _photosController;

  /// Подписка на значения поля
  late StreamSubscription<BuiltList<AlbumPhoto>?>? _photosSubscription;

  ///
  Album? getAlbumDetails() {
    return _album;
  }

  ///  .
  void clearAlbumDetails() {
    actions.albumDetailsScreen.clearAlbumDetails(null);
  }

  @override
  void init() {
    super.init();
    _albumDetailsScreenStatusSubscription = store
        ?.nextSubstate((AppState state) => state.albumDetailsState.screenStatus)
        .listen((ScreenStatusEnum? screenStatus) {
      if (screenStatus != null) {
        _albumDetailsScreenStatusController?.sink.add(screenStatus);
      }
    });
    _albumDetailsScreenStatusController = StreamController<ScreenStatusEnum>.broadcast();

    _photosSubscription = store
        ?.nextSubstate((AppState state) => state.albumDetailsState.album?.photos)
        .listen((BuiltList<AlbumPhoto>? photos) {
      if (photos != null) {
        _photosController?.sink.add(photos.toList());
      }
    });
    _photosController = StreamController<List<AlbumPhoto>?>.broadcast();
  }

  ///
  void loadAlbumInfo() {
    _album = store!.state.userDetailsState.user!.albums!.firstWhere((_album) => _album.id == albumId);

    Future.delayed(const Duration(microseconds: 1)) //для разделения инциализирующего потока (чтоб инит не перекрывал)
        .then((value) => {
              if (_album != null)
                {
                  store!.actions.albumDetailsScreen.setAlbumDetails(_album!),
                  _albumDetailsScreenStatusController?.sink.add(ScreenStatusEnum.wait),
                }
              else
                {
                  _albumDetailsScreenStatusController?.sink.add(ScreenStatusEnum.loading),
                }
            });
  }

  @override
  void dispose() {
    _albumDetailsScreenStatusController?.close();
    _albumDetailsScreenStatusSubscription?.cancel();
    _photosController?.close();
    _photosSubscription?.cancel();
    super.dispose();
  }

  ///
  loadAlbumPhotos() {
    var _photos = _album!.photos?.toList();
    if (_photos != null && _photos.isNotEmpty) {
      _photosController?.sink.add(_photos);
    } else {
      _downloadAlbumPhotos();
    }
  }

  ///
  _downloadAlbumPhotos() {
    final request = AlbumPhotosRequest((builder) => builder..albumId = albumId);
    // Выполяем запрос.
    store?.actions.albumDetailsScreen.albumPhotosRequest(request);
    store?.actions.albumDetailsScreen.setAlbumDetailsScreenStatus(ScreenStatusEnum.loading);
  }
}
