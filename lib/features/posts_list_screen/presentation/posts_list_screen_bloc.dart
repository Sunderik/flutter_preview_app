import 'dart:async';
import 'package:azorin_test/features/user_details_screen/repository/models/user_posts_request.dart';
import 'package:built_collection/built_collection.dart';

import 'package:azorin_test/features/posts_list_screen/domain/domain.dart';
import 'package:azorin_test/core/core.dart';

///
class PostsListScreenBloc extends BaseBloc {
  final int userId;

  PostsListScreenBloc(this.userId);

  /// Возвращает коллекцию исполнителей.
  BuiltList<Post>? get posts =>
      store?.state.usersState.users.firstWhere((user) => user.id == userId).posts?.toBuiltList();

  /// Контроллер статуса экрана.
  late StreamController<ScreenStatusEnum> postsListScreenStatusController;

  /// Контроллер команды проекта.
  late StreamController<BuiltList<Post>> postsController;

  /// Подписка на значение поля [PostsListScreenState.usersListScreenStatus].
  StreamSubscription<ScreenStatusEnum?>? _postsListScreenStatusSubscription;


  @override
  void init() {
    super.init();

    postsController = StreamController<BuiltList<Post>>.broadcast();
    postsListScreenStatusController = StreamController<ScreenStatusEnum>();

    _postsListScreenStatusSubscription =
        store?.nextSubstate((AppState state) => state.postsListState.postsListScreenStatus).listen((status) {
      if (status != null) {
        postsListScreenStatusController.sink.add(status);
      }
    });

    _sinkPostsList();
  }

  @override
  void dispose() {
    super.dispose();
    postsController.close();
    postsListScreenStatusController.close();
    _postsListScreenStatusSubscription?.cancel();
  }


  /// Переход на окно "Информацию о пользователе".
  ///
  /// [post] - объект поста, на информацию о котором выполяется переход.
  void openPostInfo(Post post) {
    // logger.i('Opening UserDetails for user with id:${user.id}');
    // final bundle = {'userId': user.id};
    // actions.navigation.routeTo(
    //   AppRoute((builder) => builder
    //     ..route = Routes.userDetails
    //     ..bundle = bundle),
    // );
  }

  /// Отправить в контроллер команды обновленых участников проекта.
  void _sinkPostsList() {
    final _posts = posts;
    if (_posts == null) {
      return;
    }
    postsController.sink.add(_posts);
    postsListScreenStatusController.sink.add(ScreenStatusEnum.wait);
  }
}
