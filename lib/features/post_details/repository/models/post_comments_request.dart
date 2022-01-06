import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '_models.dart';

part 'post_comments_request.g.dart';

///
abstract class PostCommentsRequest implements Built<PostCommentsRequest, PostCommentsRequestBuilder> {
  ///
  int get postId;

  PostCommentsRequest._();

  ///
  factory PostCommentsRequest([void Function(PostCommentsRequestBuilder) updates]) = _$PostCommentsRequest;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(PostCommentsRequest.serializer, this) as Map<String, dynamic>;
  }

  ///
  static PostCommentsRequest? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PostCommentsRequest.serializer, json);
  }

  ///
  static Serializer<PostCommentsRequest> get serializer => _$postCommentsRequestSerializer;
}
