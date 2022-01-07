import 'dart:convert';
import 'package:azorin_test/features/album_details/repository/endpoints/album_photos_endpoint.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/network/models/rest_bundle.dart';
import 'package:azorin_test/core/network/service/rest_service.dart';
import 'package:azorin_test/core/utilities/isolate_manager/isolate_manager_mixin.dart';
import 'package:azorin_test/core/library/logger/logger.dart';

import 'models/_models.dart';

///
abstract class AlbumDetailsRepository {
  ///
  Stream<AlbumPhotosResponse> makeAlbumPhotosRequest({required int albumId, Duration timeout});
}

///
@Injectable(as: AlbumDetailsRepository)
class AlbumDetailsRepositoryImpl with IsolateManagerMixin implements AlbumDetailsRepository {
  late final RestService _restService;
  late final UrlFactory _urlFactory;

  AlbumDetailsRepositoryImpl(this._restService, this._urlFactory);

  @override
  Stream<AlbumPhotosResponse> makeAlbumPhotosRequest(
      {required int albumId, Duration timeout = const Duration(seconds: 20)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<AlbumPhotosResponse>();
    subscribe(inputSubject, outputSubject, albumPhotosMapRestBundle);
    _makeAlbumPhotosRequest(
      input: inputSubject,
      output: outputSubject,
      albumId: albumId,
      timeout: timeout,
    );

    return outputSubject.map((output) => output);
  }

  ///
  void _makeAlbumPhotosRequest(
      {required BehaviorSubject<RestBundle> input,
      required BehaviorSubject<AlbumPhotosResponse> output,
      required int albumId,
      required Duration timeout}) {
    final endpoint = AlbumPhotosEndpoint(albumId);
    final url = _urlFactory.createFor<AlbumPhotosEndpoint>(endpoint);
    executeGetRestRequest(
      input,
      output,
      _restService,
      url,
      AlbumPhotosResponse.serializer,
      timeout,
    );
  }
}

///
AlbumPhotosResponse albumPhotosMapRestBundle(RestBundle bundle) {
  if (bundle.status != 200) {
    return AlbumPhotosResponse((builder) => builder
      ..httpCode = bundle.status
      ..message = bundle.data.toString());
  }
  try {
    final jsonDecoded = {"photos": jsonDecode(bundle.data ?? '')};
    AlbumPhotosResponse response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } catch (err) {
    logger.e('albumPhotosMapRestBundle $err');
    return AlbumPhotosResponse((builder) => builder.httpCode = bundle.status);
  }
}
