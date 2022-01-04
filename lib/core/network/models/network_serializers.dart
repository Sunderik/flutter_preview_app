import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'network_serializers.g.dart';

/// Сетевой сериализатор.
@SerializersFor([
  // TODO: add the built values that require serialization
])
final Serializers serializers =
    (_$serializers.toBuilder()
        ..addPlugin(StandardJsonPlugin())).build();
