import 'package:azorin_test/features/albums_list_screen/domain/actions/albums_list_actions.dart';
import 'package:built_redux/built_redux.dart';

import 'package:azorin_test/core/domain/actions/domain_actions/users_actions.dart';
import 'package:azorin_test/features/navigation/navigation.dart';
import 'package:azorin_test/features/posts_list_screen/domain/actions/posts_list_actions.dart';
import 'package:azorin_test/features/user_details_screen/domain/actions/user_details_actions.dart';
import 'package:azorin_test/features/users_list_screen/domain/actions/users_list_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_actions.g.dart';

/// Интерфес всех действий в приложении.
abstract class AppActions extends ReduxActions {
  /// Конструктор.
  AppActions._();

  /// Фабрика класса.
  factory AppActions() => _$AppActions();

  /// Действие очистки весех стейтов приложения.
  late ActionDispatcher<void> clearState;

  /// Действие установки темы в приложении.
  late ActionDispatcher<void> setTheme;

  /// Действие сохранения всего стейта приложения в [SharedPreferences].
  late ActionDispatcher<void> saveState;

  /// Действия со стейтом навигации в приложении.
  NavigationActions get navigation;

  /// Действия с базовым стейтом пользователей.
  UsersActions get users;

  /// Действия с стейтом экрана пользователей.
  UsersListScreenActions get usersScreen;

  /// Действия с стейтом экрана постов пользователя.
  PostsListScreenActions get postsScreen;

  /// Действия с стейтом экрана альбомов пользователя.
  AlbumsListScreenActions get albumsScreen;

  /// Действия с стейтом экрана информации о пользователе.
  UserDetailsActions get userScreen;
}
