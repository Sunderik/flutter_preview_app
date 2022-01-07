import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'album_photo.g.dart';

/// Модель фотографии из альбома.
abstract class AlbumPhoto implements Built<AlbumPhoto, AlbumPhotoBuilder> {
  /// Идентификатор фотографии.
  int? get id;

  /// Идентификатор альбома.
  int? get albumId;

  /// Заголовок фотографии.
  String? get title;

  /// Ссылка на фотографию.
  String? get url;

  /// Ссылка на превью фотографии.
  String? get thumbnailUrl;

  AlbumPhoto._();

  /// Фабрика класса.
  factory AlbumPhoto([void Function(AlbumPhotoBuilder) updates]) = _$AlbumPhoto;

  /// Конвертировать модель [AlbumPhoto] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(AlbumPhoto.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [AlbumPhoto].
  static AlbumPhoto? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(AlbumPhoto.serializer, json);
  }

  /// Сериализатор модели [AlbumPhoto].
  static Serializer<AlbumPhoto> get serializer => _$albumPhotoSerializer;
}
