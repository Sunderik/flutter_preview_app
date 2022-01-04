import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:azorin_test/core/core.dart';
import 'package:built_value/serializer.dart';

part 'user_details_state.g.dart';

///
abstract class UserDetailsState implements Built<UserDetailsState, UserDetailsStateBuilder> {
  /// Объект выбранного опльзователя
  User? get user;

  /// Статус экрана.
  ScreenStatusEnum? get screenStatus;

  UserDetailsState._();

  ///
  factory UserDetailsState([void Function(UserDetailsStateBuilder) updates]) = _$UserDetailsState;

  ///
  String toJson() {
    return json.encode(mainSerializers.serializeWith(UserDetailsState.serializer, this));
  }

  ///
  static UserDetailsState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(UserDetailsState.serializer, json.decode(jsonString));
  }

  ///
  static Serializer<UserDetailsState> get serializer => _$userDetailsStateSerializer;
}
