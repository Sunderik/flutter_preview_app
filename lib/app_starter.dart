import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart';

import 'core/domain/actions/app_actions.dart';
import 'core/domain/domain.dart';
import 'core/domain/middlewares/middelware_builder.dart';
import 'core/services/cache_data_sevice.dart';
import 'injection.dart';

/// Приватная переменная стора.
///
/// Хранит все данные приложения.
Store<AppState, AppStateBuilder, AppActions>? _store;

/// Свойство доступа переменной стора.
Store<AppState, AppStateBuilder, AppActions>? get store => _store;

/// Метод запуска инициализаци хранилища данных.
startApp() async {
  AppState? _data = await injector.get<CacheDataService>().getData();

  _store = Store(
    reducers,
    _data ?? AppState(),
    AppActions(),
    middleware: middlewares,
  );
}
