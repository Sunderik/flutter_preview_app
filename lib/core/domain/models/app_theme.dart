import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_theme.g.dart';

/// Перечисление тем приложения.
class AppTheme extends EnumClass {
  /// Светлая тема.
  static const AppTheme light = _$light;

  /// Темная тема.
  static const AppTheme dark = _$dark;

  const AppTheme._(String name) : super(name);

  /// Занчения перечисления.
  static BuiltSet<AppTheme> get values => _$appThemeValues;

  /// Получить значение по имени [name].
  static AppTheme valueOf(String name) => _$appThemeValueOf(name);

  /// Сериализатор класса [AppTheme].
  static Serializer<AppTheme> get serializer => _$appThemeSerializer;
}