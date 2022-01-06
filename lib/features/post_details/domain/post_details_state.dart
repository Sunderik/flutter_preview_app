import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:azorin_test/core/core.dart';
import 'package:built_value/serializer.dart';

part 'post_details_state.g.dart';

///
abstract class PostDetailsState implements Built<PostDetailsState, PostDetailsStateBuilder> {
  /// Объект выбранного поста.
  Post? get post;

  /// Статус экрана.
  ScreenStatusEnum? get screenStatus;

  PostDetailsState._();

  ///
  factory PostDetailsState([void Function(PostDetailsStateBuilder) updates]) = _$PostDetailsState;

  ///
  String toJson() {
    return json.encode(mainSerializers.serializeWith(PostDetailsState.serializer, this));
  }

  ///
  static PostDetailsState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(PostDetailsState.serializer, json.decode(jsonString));
  }

  ///
  static Serializer<PostDetailsState> get serializer => _$postDetailsStateSerializer;
}
