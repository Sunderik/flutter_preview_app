import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/core.dart';

import '_models.dart';

part 'user_posts_response.g.dart';

///
abstract class UserPostsResponse implements BaseModel, Built<UserPostsResponse, UserPostsResponseBuilder> {
  ///
  BuiltList<Post>? get posts;

  UserPostsResponse._();

  ///
  factory UserPostsResponse([void Function(UserPostsResponseBuilder) updates]) = _$UserPostsResponse;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(UserPostsResponse.serializer, this) as Map<String, dynamic>;
  }

  ///
  static UserPostsResponse? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserPostsResponse.serializer, json);
  }

  ///
  static Serializer<UserPostsResponse> get serializer => _$userPostsResponseSerializer;
}
