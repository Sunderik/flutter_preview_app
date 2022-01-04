import 'package:azorin_test/core/domain/models/post.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

import '_models.dart';

part 'user.g.dart';

/// Модель пользователя.
abstract class User implements Built<User, UserBuilder> {
  /// Идентификатор пользователя.
  int? get id;

  /// Имя пользователя.
  String? get name;

  /// Логин пользователя.
  @BuiltValueField(wireName: 'username')
  String? get userName;

  /// Почта.
  String? get email;

  /// Обьект адреса.
  Address? get address;

  /// Обьект компании.
  Company get company;

  /// Телефон.
  String? get phone;

  /// Веб-сайт.
  String? get website;

  /// Списко постов пользователя.
  BuiltList<Post>? get posts;

  /// Список альбомов пользователя.
  BuiltList<Album>? get albums;

  User._();

  /// Фабрика класса.
  factory User([void Function(UserBuilder) updates]) = _$User;

  /// Конвертировать модель [User] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(User.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [User].
  static User? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(User.serializer, json);
  }

  /// Сериализатор модели [User].
  static Serializer<User> get serializer => _$userSerializer;
}
