 import 'dart:convert';

import 'package:azorin_test/core/core.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'posts_list_state.g.dart';
///
abstract class PostsListScreenState implements Built<PostsListScreenState, PostsListScreenStateBuilder> {
  /// Статус экрана.
  ScreenStatusEnum? get postsListScreenStatus;

  PostsListScreenState._();

  factory PostsListScreenState([void Function(PostsListScreenStateBuilder) updates]) = _$PostsListScreenState;

  ///
  String toJson() {
    return json.encode(mainSerializers.serializeWith(PostsListScreenState.serializer, this));
  }

  ///
  static PostsListScreenState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(PostsListScreenState.serializer, json.decode(jsonString));
  }

  ///
  static Serializer<PostsListScreenState> get serializer => _$postsListScreenStateSerializer;
}
