import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'routes.g.dart';

class Routes extends EnumClass {
  static const Routes pop = _$pop;
  static const Routes userDetails = _$userDetails;
  static const Routes usersList = _$usersList;
  static const Routes postsList = _$postsList;
  static const Routes albumsList = _$albumsList;
  static const Routes showMap = _$showMap;


  const Routes._(String name) : super(name);

  static BuiltSet<Routes> get values => _$routesValues;
  static Routes valueOf(String name) => _$routesValueOf(name);
}
