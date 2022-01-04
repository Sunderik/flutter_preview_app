import 'dart:convert';

import 'package:azorin_test/core/domain/models/user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';
import 'package:azorin_test/core/domain/domain.dart';

part 'users_state.g.dart';

/// Стейт базовый для хранения списка пользователей [users]
abstract class UsersState implements Built<UsersState, UsersStateBuilder> {
  /// Хранимый список пользователей
  BuiltList<User> get users;

  UsersState._();

  /// Фабрика класса стейт.
  factory UsersState([void Function(UsersStateBuilder) updates]) = _$UsersState;

  /// Конвертировать стейт в сторку.
  String toJson() {
    return json.encode(mainSerializers.serializeWith(UsersState.serializer, this));
  }

  /// Конвертировать стейт из строки [jsonString] в модель состояния [UsersState].
  static UsersState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(UsersState.serializer, json.decode(jsonString));
  }

  /// Сериализатор состояния [UsersState].
  static Serializer<UsersState> get serializer => _$usersStateSerializer;
}
