import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/album_details/repository/models/album_photos_request.dart';
import 'package:azorin_test/features/album_details/repository/models/album_photos_response.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

///
@SerializersFor([AlbumPhotosRequest, AlbumPhotosResponse])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
