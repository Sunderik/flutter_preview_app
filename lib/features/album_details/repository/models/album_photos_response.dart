import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/core.dart';

import '_models.dart';

part 'album_photos_response.g.dart';

///
abstract class AlbumPhotosResponse implements BaseModel, Built<AlbumPhotosResponse, AlbumPhotosResponseBuilder> {
  ///
  BuiltList<AlbumPhoto>? get photos;

  AlbumPhotosResponse._();

  ///
  factory AlbumPhotosResponse([void Function(AlbumPhotosResponseBuilder) updates]) = _$AlbumPhotosResponse;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AlbumPhotosResponse.serializer, this) as Map<String, dynamic>;
  }

  ///
  static AlbumPhotosResponse? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AlbumPhotosResponse.serializer, json);
  }

  ///
  static Serializer<AlbumPhotosResponse> get serializer => _$albumPhotosResponseSerializer;
}
