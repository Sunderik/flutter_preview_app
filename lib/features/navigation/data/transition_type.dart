import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'transition_type.g.dart';

class TransitionType extends EnumClass {
  /// Анимация перехода: назад
  static const TransitionType backSlide = _$backSlide;

  /// Анимация перехода: постепенное появление
  static const TransitionType fade = _$fade;

  /// Анимация перехода: сдвиг вправо
  static const TransitionType rightSlide = _$rightSlide;

  /// Анимация перехода: сжатие
  static const TransitionType scale = _$scale;

  /// Анимация перехода: расширение
  static const TransitionType size = _$size;

  /// Анимация перехода: базовая
  static const TransitionType def = _$def;

  const TransitionType._(String name) : super(name);

  static BuiltSet<TransitionType> get values => _$transitionTypeValues;

  static TransitionType valueOf(String name) => _$transitionTypeValueOf(name);
}
