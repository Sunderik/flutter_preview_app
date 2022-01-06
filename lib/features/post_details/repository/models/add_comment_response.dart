import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/core.dart';

import '_models.dart';

part 'add_comment_response.g.dart';

///
abstract class AddCommentResponse implements BaseModel, Built<AddCommentResponse, AddCommentResponseBuilder> {
  ///
  Comment? get comment;

  AddCommentResponse._();

  ///
  factory AddCommentResponse([void Function(AddCommentResponseBuilder) updates]) = _$AddCommentResponse;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(AddCommentResponse.serializer, this) as Map<String, dynamic>;
  }

  ///
  static AddCommentResponse? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AddCommentResponse.serializer, json);
  }

  ///
  static Serializer<AddCommentResponse> get serializer => _$addCommentResponseSerializer;
}
