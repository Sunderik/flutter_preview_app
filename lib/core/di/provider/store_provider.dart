import 'package:azorin_test/app_starter.dart' as starter;
import 'package:azorin_test/core/domain/domain.dart';
import 'package:built_redux/built_redux.dart';
import 'package:injectable/injectable.dart';

/// Интерфейс провадера к хранилищу данных.
abstract class StoreProvider {
  /// Свойство получения хранилища данных
  Store<AppState, AppStateBuilder, AppActions>? get store;
}

/// Реализация интерфейса [StoreProvider].
@Injectable(as: StoreProvider)
class StoreProviderImpl implements StoreProvider {
  @override
  Store<AppState, AppStateBuilder, AppActions>? get store => starter.store;
}
