import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:azorin_test/core/core.dart';
import 'package:built_value/serializer.dart';

part 'album_details_state.g.dart';

///
abstract class AlbumDetailsState implements Built<AlbumDetailsState, AlbumDetailsStateBuilder> {
  /// Объект выбранного альбома.
  Album? get album;

  /// Статус экрана.
  ScreenStatusEnum? get screenStatus;

  AlbumDetailsState._();

  ///
  factory AlbumDetailsState([void Function(AlbumDetailsStateBuilder) updates]) = _$AlbumDetailsState;

  ///
  String toJson() {
    return json.encode(mainSerializers.serializeWith(AlbumDetailsState.serializer, this));
  }

  ///
  static AlbumDetailsState? fromJson(String jsonString) {
    return mainSerializers.deserializeWith(AlbumDetailsState.serializer, json.decode(jsonString));
  }

  ///
  static Serializer<AlbumDetailsState> get serializer => _$albumDetailsStateSerializer;
}
