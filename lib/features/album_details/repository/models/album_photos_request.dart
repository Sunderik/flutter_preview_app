import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '_models.dart';

part 'album_photos_request.g.dart';

///
abstract class AlbumPhotosRequest implements Built<AlbumPhotosRequest,AlbumPhotosRequestBuilder> {
  ///
  int get albumId;

  AlbumPhotosRequest._();

  ///
  factory AlbumPhotosRequest([void Function(AlbumPhotosRequestBuilder) updates]) = _$AlbumPhotosRequest;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AlbumPhotosRequest.serializer, this) as Map<String, dynamic>;
  }

  ///
  static AlbumPhotosRequest? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AlbumPhotosRequest.serializer, json);
  }

  ///
  static Serializer<AlbumPhotosRequest> get serializer => _$albumPhotosRequestSerializer;
}
