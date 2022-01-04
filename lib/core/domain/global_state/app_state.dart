import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/domain/global_state/domain_states/users_state.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';
import 'package:azorin_test/core/services/cache_data_sevice.dart';

import 'package:azorin_test/features/navigation/navigation.dart';
import 'package:azorin_test/features/albums_list_screen/domain/albums_list_state.dart';
import 'package:azorin_test/features/posts_list_screen/domain/posts_list_state.dart';
import 'package:azorin_test/features/users_list_screen/domain/users_list_state.dart';
import 'package:azorin_test/injection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_state.g.dart';

/// Базовый стейт приложения.
abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppState._();

  /// Фабрика базового стейта.
  factory AppState([void Function(AppStateBuilder)? updates]) {
    return _$AppState((b) => b
      ..appTheme = AppTheme.light
      ..navigationState = NavigationState((builder) => builder).toBuilder()
      ..usersState = UsersState().toBuilder()
      ..usersListState = UsersListScreenState().toBuilder()
      ..postsListState = PostsListScreenState().toBuilder()
      ..userDetailsState = UserDetailsState().toBuilder());
  }

  /// Свойство темы приложения.
  AppTheme get appTheme;

  /// Стейт навигации.
  NavigationState get navigationState;

  /// Стейт пользователей.
  UsersState get usersState;

  /// Стейт окна списка пользователей.
  UsersListScreenState get usersListState;

  /// Сейт окна списка постов пользователя.
  PostsListScreenState get postsListState;

  /// Сейт окна списка альбомов пользователя.
  AlbumsListScreenState get albumsListState;

  /// Сейт окна информации о пользователе.
  UserDetailsState get userDetailsState;

  ///
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(AppState.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать стейт из карты [json] в модель состояния [AppState].
  static AppState? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return mainSerializers.deserializeWith(AppState.serializer, json);
    }
  }

  /// Сериализатор состояния.
  static Serializer<AppState> get serializer => _$appStateSerializer;
}
