import 'package:azorin_test/core/core.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_redux/built_redux.dart';

part 'users_actions.g.dart';

/// Интерфес базовых действий со стейтом [UsersState].
abstract class UsersActions extends ReduxActions {
  /// Конструктор.
  UsersActions._();

  /// Фабрика класса.
  factory UsersActions() => _$UsersActions();

  /// Перезапись списка пользователей в стейт.
  late ActionDispatcher<BuiltList<User>> setUsers;

  /// Удаление списка пользователей из стейта.
  late ActionDispatcher<void> clear;
}
