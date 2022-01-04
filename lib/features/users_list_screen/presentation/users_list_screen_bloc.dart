import 'dart:async';
import 'package:built_collection/built_collection.dart';

import 'package:azorin_test/features/users_list_screen/domain/domain.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:azorin_test/features/navigation/domain/app_route.dart';
import 'package:azorin_test/features/navigation/navigation.dart';

///
class UsersListScreenBloc extends BaseBloc {
  UsersListScreenBloc();

  /// Возвращает коллекцию исполнителей.
  BuiltList<User>? get users => store?.state.usersState.users.toBuiltList();

  /// Контроллер статуса экрана.
  late StreamController<ScreenStatusEnum> usersListScreenStatusController;

  /// Контроллер команды проекта.
  late StreamController<BuiltList<User>> usersController;

  /// Подписка на значение поля [UsersListScreenState.usersListScreenStatus].
  StreamSubscription<ScreenStatusEnum?>? _usersListScreenStatusSubscription;

  /// Контроллер пользователей.
  late StreamSubscription<BuiltList<User>?> _usersSubscription;

  @override
  void init() {
    super.init();

    usersController = StreamController<BuiltList<User>>.broadcast();

    usersListScreenStatusController = StreamController<ScreenStatusEnum>();

    // Получаем количество пользователей.
    final _usersCount = users?.length ?? 0;

    // Обновляем список исполнителей, если количество исполнителей меньше 2.
    if (_usersCount < 2) refreshUsersList();

    _usersSubscription = store!.nextSubstate((AppState state) => state.usersState.users).listen((_) {
      _sinkUsersList();
    });

    _usersListScreenStatusSubscription =
        store?.nextSubstate((AppState state) => state.usersListState.usersListScreenStatus).listen((status) {
      if (status != null) {
        switch (status) {
          case ScreenStatusEnum.wait:
            store?.actions.usersScreen.setUsersListScreenStatus(ScreenStatusEnum.wait);
            break;
          case ScreenStatusEnum.fail:
            store?.actions.usersScreen.setUsersListScreenStatus(ScreenStatusEnum.fail);
            break;
          default:
            usersListScreenStatusController.sink.add(status);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    usersController.close();
    usersListScreenStatusController.close();
    _usersListScreenStatusSubscription?.cancel();
    _usersSubscription.cancel();
  }

  /// Обновление списка пользователй.
  void refreshUsersList() {
    // Меняем статус экрана на загрузку.
    actions.usersScreen.setUsersListScreenStatus(ScreenStatusEnum.loading);
    // Выполяем запрос пользователей.
    actions.usersScreen.usersRequest(null);
    _sinkUsersList();
  }

  /// Переход на окно "Информацию о пользователе".
  ///
  /// [user] - объект исполнителя, на информацию о котором выполяется переход.
  void openUserInfo(User user) {
    logger.i('Opening UserDetails for user with id:${user.id}');
    final bundle = {'userId': user.id};
    actions.navigation.routeTo(
      AppRoute((builder) => builder
        ..route = Routes.userDetails
        ..navigationType = NavigationType.push
        ..transitionType = TransitionType.rightSlide
        ..bundle = bundle),
    );
  }

  /// Отправить в контроллер команды обновленых участников проекта.
  void _sinkUsersList() {
    final users = this.users;
    if (users == null) {
      return;
    }
    usersController.sink.add(users);
  }
}
