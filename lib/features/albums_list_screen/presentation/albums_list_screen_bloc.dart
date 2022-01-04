import 'dart:async';
import 'package:azorin_test/features/user_details_screen/repository/models/user_albums_request.dart';
import 'package:built_collection/built_collection.dart';

import 'package:azorin_test/features/albums_list_screen/domain/domain.dart';
import 'package:azorin_test/core/core.dart';

///
class AlbumsListScreenBloc extends BaseBloc {
  final int userId;

  AlbumsListScreenBloc(this.userId);

  /// Возвращает коллекцию исполнителей.
  BuiltList<Album>? get albums =>
      store?.state.usersState.users.firstWhere((user) => user.id == userId).albums?.toBuiltList();

  /// Контроллер статуса экрана.
  late StreamController<ScreenStatusEnum> albumsListScreenStatusController;

  /// Контроллер команды проекта.
  late StreamController<BuiltList<Album>> albumsController;

  /// Подписка на значение поля [AlbumsListScreenState.usersListScreenStatus].
  StreamSubscription<ScreenStatusEnum?>? _albumsListScreenStatusSubscription;


  @override
  void init() {
    super.init();

    albumsController = StreamController<BuiltList<Album>>.broadcast();
    albumsListScreenStatusController = StreamController<ScreenStatusEnum>();

    _albumsListScreenStatusSubscription =
        store?.nextSubstate((AppState state) => state.albumsListState.albumsListScreenStatus).listen((status) {
      if (status != null) {
        albumsListScreenStatusController.sink.add(status);
      }
    });

    _sinkAlbumsList();
  }

  @override
  void dispose() {
    super.dispose();
    albumsController.close();
    albumsListScreenStatusController.close();
    _albumsListScreenStatusSubscription?.cancel();
  }


  /// Переход на окно "Информацию о пользователе".
  ///
  /// [album] - объект поста, на информацию о котором выполяется переход.
  void openAlbumInfo(Album album) {
    // logger.i('Opening UserDetails for user with id:${user.id}');
    // final bundle = {'userId': user.id};
    // actions.navigation.routeTo(
    //   AppRoute((builder) => builder
    //     ..route = Routes.userDetails
    //     ..bundle = bundle),
    // );
  }

  /// Отправить в контроллер команды обновленых участников проекта.
  void _sinkAlbumsList() {
    final _albums = albums;
    if (_albums == null) {
      return;
    }
    albumsController.sink.add(_albums);
    albumsListScreenStatusController.sink.add(ScreenStatusEnum.wait);
  }
}
