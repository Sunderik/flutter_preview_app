import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '_models.dart';

part 'user_albums_request.g.dart';

///
abstract class UserAlbumsRequest implements Built<UserAlbumsRequest, UserAlbumsRequestBuilder> {
  ///
  int get userId;

  UserAlbumsRequest._();

  ///
  factory UserAlbumsRequest([void Function(UserAlbumsRequestBuilder) updates]) = _$UserAlbumsRequest;

  ///
  Map<String, dynamic>? toJson() {
    return serializers.serializeWith(UserAlbumsRequest.serializer, this) as Map<String, dynamic>;
  }

  ///
  static UserAlbumsRequest? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserAlbumsRequest.serializer, json);
  }

  ///
  static Serializer<UserAlbumsRequest> get serializer => _$userAlbumsRequestSerializer;
}
