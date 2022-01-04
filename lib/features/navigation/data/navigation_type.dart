import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'navigation_type.g.dart';

class NavigationType extends EnumClass {
  /// Push the given route onto the navigator.
  static const NavigationType push = _$push;

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  static const NavigationType pushReplacement = _$pushReplacement;

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  static const NavigationType pushAndRemoveUntil = _$pushAndRemoveUntil;

  const NavigationType._(String name) : super(name);

  static BuiltSet<NavigationType> get values => _$navigationTypeValues;
  static NavigationType valueOf(String name) => _$navigationTypeValueOf(name);
}