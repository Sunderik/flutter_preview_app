import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Иньяекция модуля с [SharedPreferences].
@module
abstract class InjectionModule {
  /// Инициализированный обьект [SharedPreferences].
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
