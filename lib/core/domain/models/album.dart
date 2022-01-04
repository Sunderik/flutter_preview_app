import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'album.g.dart';

/// Модель альбома.
abstract class Album implements Built<Album, AlbumBuilder> {
  /// Идентификатор альбома.
  int? get id;

  /// Идентификатор пользователя.
  int? get userId;

  /// Идентификатор названия альбома.
  String? get title;

  Album._();

  /// Фабрика класса.
  factory Album([void Function(AlbumBuilder) updates]) = _$Album;

  /// Конвертировать модель [Album] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(Album.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [Album].
  static Album? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(Album.serializer, json);
  }

  /// Сериализатор модели [Album].
  static Serializer<Album> get serializer => _$albumSerializer;
}
