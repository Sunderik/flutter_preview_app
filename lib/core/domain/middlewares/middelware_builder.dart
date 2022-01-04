import 'package:azorin_test/core/core.dart';

import 'package:azorin_test/features/navigation/navigation.dart';
import 'package:azorin_test/features/user_details_screen/domain/middlewares/epic/user_details_epic.dart';
import 'package:azorin_test/features/user_details_screen/domain/middlewares/user_details_middleware.dart';
import 'package:azorin_test/features/users_list_screen/domain/middlewares/epics/users_list_epic.dart';
import 'package:azorin_test/features/users_list_screen/domain/middlewares/users_list_middleware.dart';
import 'package:azorin_test/injection.dart';
import 'package:built_redux/built_redux.dart';

/// Эпик экрана списка пользователей.
final _usersListEpic = injector.get<UsersListEpic>();

/// Эпик экрана информации о пользователе.
final _userDetailsEpic = injector.get<UserDetailsEpic>();

/// Список мидлваров приложения.
final List<
    void Function(Action<dynamic>) Function(void Function(Action<dynamic>)) Function(
        MiddlewareApi<AppState, AppStateBuilder, AppActions>)> middlewares = [
  navigationMiddleware().build(),
  usersListMiddleware().build(),
  userDetailsMiddleware().build(),
  createEpicMiddleware([
    _usersListEpic.usersListEpic,
    _userDetailsEpic.userPostsEpic,
    _userDetailsEpic.userAlbumsEpic,
  ])
];
