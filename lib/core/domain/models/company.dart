import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'company.g.dart';

/// Модель компании
///
/// Компания - место работы пользователя.
abstract class Company implements Built<Company, CompanyBuilder> {
  /// Навзание компании.
  String? get name;

  /// Девиз компании.
  String? get catchPhrase;

  /// Ключивая фраза компании.
  String? get bs;

  Company._();

  /// Фабрика класса.
  factory Company([void Function(CompanyBuilder) updates]) = _$Company;

  /// Конвертировать модель [Company] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(Company.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [Company].
  static Company? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(Company.serializer, json);
  }

  /// Сериализатор модели [Company].
  static Serializer<Company> get serializer => _$companySerializer;
}
