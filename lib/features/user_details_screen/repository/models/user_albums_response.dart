import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/core.dart';

import '_models.dart';

part 'user_albums_response.g.dart';

///
abstract class UserAlbumsResponse implements BaseModel, Built<UserAlbumsResponse, UserAlbumsResponseBuilder> {
  ///
  BuiltList<Album>? get albums;

  UserAlbumsResponse._();

  ///
  factory UserAlbumsResponse([void Function(UserAlbumsResponseBuilder) updates]) = _$UserAlbumsResponse;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(UserAlbumsResponse.serializer, this) as Map<String, dynamic>;
  }

  ///
  static UserAlbumsResponse? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserAlbumsResponse.serializer, json);
  }

  ///
  static Serializer<UserAlbumsResponse> get serializer => _$userAlbumsResponseSerializer;
}
