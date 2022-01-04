import 'package:azorin_test/core/core.dart';
import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/features/users_list_screen/repository/models/_models.dart';

part 'users_list_actions.g.dart';
///
abstract class UsersListScreenActions extends ReduxActions {
  UsersListScreenActions._();

  factory UsersListScreenActions() => _$UsersListScreenActions();

  /// Action запроса пользователей.
  late ActionDispatcher<void> usersRequest;

  /// Action записи ответа запроса пользователей.
  late ActionDispatcher<UsersResponse> setUsersResponse;

  /// Определение статуса экрана окна.
  late ActionDispatcher<ScreenStatusEnum> setUsersListScreenStatus;
}
