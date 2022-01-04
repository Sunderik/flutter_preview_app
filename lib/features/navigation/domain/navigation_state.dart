import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/widgets.dart' show NavigatorState, GlobalKey;

part 'navigation_state.g.dart';

abstract class NavigationState implements Built<NavigationState, NavigationStateBuilder> {
  NavigationState._();
  factory NavigationState([void Function(NavigationStateBuilder)? updates]) {
    return _$NavigationState((b) => b
      ..rootNavigatorKey = GlobalKey<NavigatorState>()
      ..update(updates));
  }

  @BuiltValueField(serialize: false)
  GlobalKey<NavigatorState>? get rootNavigatorKey;

  static Serializer<NavigationState> get serializer => _$navigationStateSerializer;
}
