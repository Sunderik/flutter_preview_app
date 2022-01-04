 import 'dart:convert';

import 'package:azorin_test/core/core.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'users_list_state.g.dart';
///
abstract class UsersListScreenState implements Built<UsersListScreenState, UsersListScreenStateBuilder> {
  /// Статус экрана.
  ScreenStatusEnum? get usersListScreenStatus;

  UsersListScreenState._();

  factory UsersListScreenState([void Function(UsersListScreenStateBuilder) updates]) = _$UsersListScreenState;

  ///
  String toJson() {
    return json.encode(mainSerializers.serializeWith(UsersListScreenState.serializer, this));
  }

  ///
  static UsersListScreenState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(UsersListScreenState.serializer, json.decode(jsonString));
  }

  ///
  static Serializer<UsersListScreenState> get serializer => _$usersListScreenStateSerializer;
}
