import 'package:azorin_test/core/di/provider/store_provider.dart';
import 'package:azorin_test/injection.dart';
import 'package:built_redux/built_redux.dart';

import '../domain/domain.dart';

/// Базовый блок.
///
/// Для наследования в блоках разных окон.
abstract class BaseBloc {
  /// Получение доступа к стору приложения.
  final StoreProvider _storeProvider = injector.get<StoreProvider>();

  /// Обьект стора приложения.
  Store<AppState, AppStateBuilder, AppActions>? get store => _storeProvider.store;

  /// Обьект доступных действий в приложении.
  AppActions get actions => store!.actions;

  /// Метод инициализации блока.
  void init() {}

  /// Метод освобождения памяти занимаемой блоком.
  void dispose() {}
}
