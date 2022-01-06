import 'package:azorin_test/features/post_details/repository/models/_models.dart';
import 'package:azorin_test/core/core.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

///
@SerializersFor([AddCommentRequest, AddCommentResponse, PostCommentsRequest, PostCommentsResponse])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
