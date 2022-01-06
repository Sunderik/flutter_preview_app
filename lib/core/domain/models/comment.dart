import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:azorin_test/core/domain/serializers/serializers.dart';

part 'comment.g.dart';

/// Модель комментария.
abstract class Comment implements Built<Comment, CommentBuilder> {
  /// Идентификатор комментария.
  int? get id;

  /// Идентификатор поста.
  int? get postId;

  /// Идентификатор названия комментария.
  String? get name;

  /// Идентификатор названия комментария.
  String? get email;

  /// Идентификатор названия комментария.
  String? get body;

  Comment._();

  /// Фабрика класса.
  factory Comment([void Function(CommentBuilder) updates]) = _$Comment;

  /// Конвертировать модель [Comment] в карту.
  Map<String, dynamic>? toJson() {
    return mainSerializers.serializeWith(Comment.serializer, this) as Map<String, dynamic>;
  }

  /// Конвертировать из строки [json] в модель состояния [Comment].
  static Comment? fromJson(Map<String, dynamic> json) {
    return mainSerializers.deserializeWith(Comment.serializer, json);
  }

  /// Сериализатор модели [Comment].
  static Serializer<Comment> get serializer => _$commentSerializer;
}
