import 'dart:async';
import 'dart:convert';

import 'package:azorin_test/core/di/provider/store_provider.dart';
import 'package:azorin_test/core/domain/global_state/app_state.dart';
import 'package:azorin_test/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Сервис для работы с файлом хранящим неотправленные запросы
@singleton
class CacheDataService {
  /// Ключ для хранения состояния приложения в [SharedPreferences]
  static const _dataKey = 'APP_DATA_KEY';

  /// Инициализированный обьект [SharedPreferences]
  static final _prefs = injector.get<SharedPreferences>();

  /// Провайдер харнилища приложения
  final StoreProvider _storeProvider = injector.get<StoreProvider>();

  /// Запись данных в [SharedPreferences] по ключу [_dataKey].
  Future<void> setData() async {
    try {
      var _jsonMap = _storeProvider.store!.state.toJson();
      String _jsonString = jsonEncode(_jsonMap);
      await _prefs.setString(_dataKey, _jsonString);
    } catch (e) {
      rethrow;
    }
  }

  /// Получение данных из [SharedPreferences] по ключу [_dataKey].
  Future<AppState?> getData<T>() async {
    try {
      String _jsonString = '';
      _jsonString = _prefs.getString(_dataKey) ?? '';
      var _jsonMap = _jsonString.isNotEmpty ? jsonDecode(_jsonString) : null;
      return AppState.fromJson(_jsonMap);
    } catch (e) {
      rethrow;
    }
  }

  /// Проверка наличия  данных в [SharedPreferences] по ключу [_dataKey].
  Future<bool> checkData() async {
    try {
      return _prefs.containsKey(_dataKey);
    } catch (e) {
      rethrow;
    }
  }

  /// Очистка данных в [SharedPreferences] по ключу [_dataKey].
  Future<void> clearData() async {
    try {
      await _prefs.remove(_dataKey);
    } catch (e) {
      rethrow;
    }
  }
}
