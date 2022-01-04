import 'dart:typed_data';

import 'package:built_value/serializer.dart';

/// Универсальная модель ответа.
class RestBundle {
  /// Ключ обьекта
  final String? key;

  /// Ответ от сервера
  final String? data;

  /// Тело ответа в байтах
  final Uint8List? bodyBytes;

  /// Сериализатор для данного ответа
  final Serializer? serializer;

  /// Максимальное время ожидания
  final Duration? timeout;

  /// Код ответа (статус)
  final int? status;

  /// Конструктор модели.
  RestBundle({this.key, this.data, this.bodyBytes, this.serializer, this.timeout, this.status});
}
