import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '_models.dart';

part 'user_posts_request.g.dart';

///
abstract class UserPostsRequest implements Built<UserPostsRequest, UserPostsRequestBuilder> {
  ///
  int get userId;

  UserPostsRequest._();

  ///
  factory UserPostsRequest([void Function(UserPostsRequestBuilder) updates]) = _$UserPostsRequest;

  ///
  String toJson() {
    return json.encode(serializers.serializeWith(UserPostsRequest.serializer, this));
  }

  ///
  static UserPostsRequest fromJson(String jsonString) {
    return serializers.deserializeWith(UserPostsRequest.serializer, json.decode(jsonString))!;
  }

  ///
  static Serializer<UserPostsRequest> get serializer => _$userPostsRequestSerializer;
}
