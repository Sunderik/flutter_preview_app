import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:azorin_test/core/core.dart';

import '_models.dart';

part 'serializers.g.dart';

///
@SerializersFor([
  UsersResponse,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
