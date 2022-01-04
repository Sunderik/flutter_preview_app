import 'package:azorin_test/core/domain/serializers/serializers.dart';
import 'package:azorin_test/core/domain/models/geolocation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'address.g.dart';

/// Модель адреса.
abstract class Address implements Built<Address, AddressBuilder> {
  /// Улица.
  String? get street;

  /// Строение.
  String? get suite;

  /// Город.
  String? get city;

  /// Почтовый индекс.
  @BuiltValueField(wireName: 'zipcode')
  String? get zipCode;

  /// Геопозиция.
  @BuiltValueField(wireName: 'geo')
  Geolocation? get geolocation;

  Address._();

  /// Фабрика класса.
  factory Address([void Function(AddressBuilder) updates]) = _$Address;

  /// Конвертировать модель [Address] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(Address.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [Address].
  static Address? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(Address.serializer, json);
  }

  /// Сериализатор модели [Address].
  static Serializer<Address> get serializer => _$addressSerializer;
}
