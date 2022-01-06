import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '_models.dart';

part 'add_comment_request.g.dart';

///
abstract class AddCommentRequest implements Built<AddCommentRequest, AddCommentRequestBuilder> {
  ///
  int get postId;

  ///
  String get name;

  ///
  String get body;

  ///
  String get email;

  AddCommentRequest._();

  ///
  factory AddCommentRequest([void Function(AddCommentRequestBuilder) updates]) = _$AddCommentRequest;

  ///
  String toJson() {
    return json.encode(serializers.serializeWith(AddCommentRequest.serializer, this));
  }

  ///
  static AddCommentRequest fromJson(String jsonString) {
    return serializers.deserializeWith(AddCommentRequest.serializer, json.decode(jsonString))!;
  }

  ///
  static Serializer<AddCommentRequest> get serializer => _$addCommentRequestSerializer;
}
