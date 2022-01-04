import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'geolocation.g.dart';

/// Модель геопозиции.
abstract class Geolocation implements Built<Geolocation, GeolocationBuilder> {
  /// Широта.
  String? get lat;

  /// Долгота.
  String? get lng;

  Geolocation._();

  /// Фабрика класса.
  factory Geolocation([void Function(GeolocationBuilder) updates]) = _$Geolocation;

  /// Конвертировать модель [Geolocation] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(Geolocation.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [Geolocation].
  static Geolocation? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(Geolocation.serializer, json);
  }

  /// Сериализатор модели [Geolocation].
  static Serializer<Geolocation> get serializer => _$geolocationSerializer;
}
