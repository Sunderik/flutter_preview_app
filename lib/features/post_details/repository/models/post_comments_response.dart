import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/core.dart';

import '_models.dart';

part 'post_comments_response.g.dart';

///
abstract class PostCommentsResponse implements BaseModel, Built<PostCommentsResponse, PostCommentsResponseBuilder> {
  ///
  BuiltList<Comment>? get comments;

  PostCommentsResponse._();

  ///
  factory PostCommentsResponse([void Function(PostCommentsResponseBuilder) updates]) = _$PostCommentsResponse;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(PostCommentsResponse.serializer, this) as Map<String, dynamic>;
  }

  ///
  static PostCommentsResponse? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PostCommentsResponse.serializer, json);
  }

  ///
  static Serializer<PostCommentsResponse> get serializer => _$postCommentsResponseSerializer;
}
