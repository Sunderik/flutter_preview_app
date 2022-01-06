import 'package:azorin_test/core/domain/models/comment.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'post.g.dart';

/// Модель поста пользователя.
abstract class Post implements Built<Post, PostBuilder> {
  /// Идентификатор поста.
  int? get id;

  /// Идентификтор пользователя.
  int? get userId;

  /// Заголовок поста.
  String? get title;

  /// Текст поста.
  String? get body;

  BuiltList<Comment>? get comments;

  Post._();

  /// Фабрика класса.
  factory Post([void Function(PostBuilder) updates]) = _$Post;

  /// Конвертировать модель [Post] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(Post.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [Post].
  static Post? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(Post.serializer, json);
  }

  /// Сериализатор модели [Post].
  static Serializer<Post> get serializer => _$postSerializer;
}
