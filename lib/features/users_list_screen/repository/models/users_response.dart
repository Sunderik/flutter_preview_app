import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'users_response.g.dart';

/// Объект переноса данных ответа на запрос получения пользователей.
abstract class UsersResponse implements BaseModel, Built<UsersResponse, UsersResponseBuilder> {
  /// Коллекция пользователей.
  BuiltList<User>? get users;

  UsersResponse._();

  ///
  factory UsersResponse([void Function(UsersResponseBuilder) updates]) = _$UsersResponse;

  ///
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(UsersResponse.serializer, this) as Map<String, dynamic>;
  }

  ///
  static UsersResponse? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(UsersResponse.serializer, json);
  }

  ///
  static Serializer<UsersResponse> get serializer => _$usersResponseSerializer;
}
