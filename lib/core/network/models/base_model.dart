library base_model;

import 'package:built_value/built_value.dart';

part 'base_model.g.dart';

/// Бащовая сетевая модель ответа
@BuiltValue(instantiable: false)
abstract class BaseModel {
  /// Код ответа
  @BuiltValueField(wireName: 'httpCode')
  int? get httpCode;

  /// Соообщение ответа (если оно есть)
  @BuiltValueField(wireName: 'message')
  String? get message;
}
