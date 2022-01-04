import 'dart:async';
import 'package:built_redux/built_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:azorin_test/features/users_list_screen/domain/actions/users_list_actions.dart';
import 'package:azorin_test/features/users_list_screen/repository/users_list_repository.dart';
///
@Injectable()
class UsersListEpic {
  UsersListEpic(this._repository);
///
  final UsersListRepository _repository;

  /// Epic запроса на получение пользователей.
  Stream usersListEpic(Stream<Action<dynamic>> stream, MiddlewareApi<AppState, AppStateBuilder, AppActions> api) {
    return stream
        .where((action) => action.name == UsersListScreenActionsNames.usersRequest.name)
        .cast<Action<void>>()
        .switchMap((action) {
      return _repository.makeUsersRequest(
        timeout: const Duration(seconds: 20),
      );
    }).doOnData((usersResponse) {
      logger.i('Received Response Body: \n$usersResponse');
      api.actions.usersScreen.setUsersResponse(usersResponse);
    }).handleError((exception) {});
  }
}
