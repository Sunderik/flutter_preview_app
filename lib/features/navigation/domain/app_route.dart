import 'package:azorin_test/features/navigation/data/navigation_type.dart';
import 'package:azorin_test/features/navigation/data/transition_type.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/widgets.dart' show BuildContext, NavigatorState;

import '../data/routes.dart';

part 'app_route.g.dart';

///
abstract class AppRoute implements Built<AppRoute, AppRouteBuilder> {
  AppRoute._();

  ///
  factory AppRoute([Function(AppRouteBuilder buider) updates]) = _$AppRoute;

  ///
  Routes get route;

  ///
  String? get payload;

  ///
  NavigationType? get navigationType;

  ///
  TransitionType? get transitionType;

  ///
  @BuiltValueField(serialize: false)
  BuildContext? get context;

  ///
  @BuiltValueField(serialize: false)
  NavigatorState? get navigatorState;

  ///
  @BuiltValueField(serialize: false)
  Object? get bundle;
}
