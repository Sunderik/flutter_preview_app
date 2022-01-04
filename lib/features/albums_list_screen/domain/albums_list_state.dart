import 'dart:convert';

import 'package:azorin_test/core/core.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'albums_list_state.g.dart';

///
abstract class AlbumsListScreenState implements Built<AlbumsListScreenState, AlbumsListScreenStateBuilder> {
  /// Статус экрана.
  ScreenStatusEnum? get albumsListScreenStatus;

  AlbumsListScreenState._();

  factory AlbumsListScreenState([void Function(AlbumsListScreenStateBuilder) updates]) = _$AlbumsListScreenState;

  ///
  String toJson() {
    return json.encode(mainSerializers.serializeWith(AlbumsListScreenState.serializer, this));
  }

  ///
  static AlbumsListScreenState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(AlbumsListScreenState.serializer, json.decode(jsonString));
  }

  ///
  static Serializer<AlbumsListScreenState> get serializer => _$albumsListScreenStateSerializer;
}
