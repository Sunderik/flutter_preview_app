import 'dart:convert';

import 'package:built_redux/built_redux.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart' hide mainSerializers;
import 'package:azorin_test/core/network/models/rest_bundle.dart';
import 'package:azorin_test/core/network/service/rest_service.dart';
import 'package:azorin_test/core/utilities/isolate_manager/isolate_manager_mixin.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:azorin_test/features/users_list_screen/repository/models/_models.dart';
import 'package:azorin_test/injection.dart';

import 'endpoint/users_list_endpoint.dart';
import 'models/serializers.dart';

///
abstract class UsersListRepository {
  /// Запрос списка пользователей.
  Stream<UsersResponse> makeUsersRequest({Duration? timeout});
}

///
@Injectable(as: UsersListRepository)
class UsersRepositoryImpl with IsolateManagerMixin implements UsersListRepository {
  ///
  final StoreProvider _storeProvider = injector.get<StoreProvider>();

  ///
  Store<AppState, AppStateBuilder, AppActions> get store => _storeProvider.store!;

  ///
  late final RestService _restService;

  ///
  late final UrlFactory _urlFactory;

  UsersRepositoryImpl(this._restService, this._urlFactory);

  @override
  Stream<UsersResponse> makeUsersRequest({Duration? timeout = const Duration(seconds: 20)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<UsersResponse>();
    subscribe(inputSubject, outputSubject, usersMapRestBundle);
    _makeUsersRequest(
      inputSubject,
      outputSubject,
      timeout: timeout,
    );
    return outputSubject;
  }

  ///
  void _makeUsersRequest(BehaviorSubject<RestBundle> input, BehaviorSubject<UsersResponse> output,
      {Duration? timeout}) {
    final endpoint = UsersListEndpoint();

    Uri url = _urlFactory.createFor<UsersListEndpoint>(endpoint);
    executeRestGetStringRequest(input, output, _restService, url, UsersResponse.serializer, timeout, headers: null);
  }
}

///
UsersResponse usersMapRestBundle(RestBundle bundle) {
  if (bundle.status != 200) {
    return UsersResponse((builder) => builder
      ..httpCode = bundle.status
      ..message = bundle.data.toString());
  }
  try {
    final jsonDecoded = {"users": jsonDecode(bundle.data ?? '')};
    UsersResponse response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } catch (err) {
    logger.e('executorsMapRestBundle $err');
    return UsersResponse((builder) => builder.httpCode = bundle.status);
  }
}
