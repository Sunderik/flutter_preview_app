import 'package:azorin_test/core/domain/domain.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:azorin_test/core/services/cache_data_sevice.dart';
import 'package:azorin_test/injection.dart';

import 'package:built_redux/built_redux.dart';

/// Создание обработчиков глобальных действий.
NestedReducerBuilder<AppState, AppStateBuilder, AppState, AppStateBuilder> createAppStateReducer() {
  return NestedReducerBuilder<AppState, AppStateBuilder, AppState, AppStateBuilder>(
    (state) => state,
    (builder) => builder,
  )
    ..add(AppActionsNames.clearState, _clearAppState)
    ..add(AppActionsNames.setTheme, _setTheme)
    ..add(AppActionsNames.saveState, _saveState);
}

/// Оработчик действия очистки всего хранилища приложения.
void _clearAppState(AppState state, Action<void> action, AppStateBuilder builder) {
  logger.i("CLEARING STATE");
  builder
    ..navigationState = NavigationState().toBuilder()
    ..usersState = UsersState().toBuilder()
    ..usersListState = UsersListScreenState().toBuilder()
    ..postsListState = PostsListScreenState().toBuilder()
    ..albumsListState = AlbumsListScreenState().toBuilder()
    ..userDetailsState = UserDetailsState().toBuilder();
}

/// Оработчик действия смены темы приложения
void _setTheme(AppState state, Action<void> action, AppStateBuilder builder) {
  logger.i("SETTING THEME");
}

/// Оработчик действия сохранения состояния приложения в кэш.
Future<void> _saveState(AppState state, Action<void> action, AppStateBuilder builder) async {
  await injector.get<CacheDataService>().setData();
}
