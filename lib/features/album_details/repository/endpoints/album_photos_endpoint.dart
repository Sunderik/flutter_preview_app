import 'package:azorin_test/core/core.dart';

///
class AlbumPhotosEndpoint implements Endpoint {
  ///
  final int? albumId;

  AlbumPhotosEndpoint(this.albumId);

  @override
  Uri create() {
    String path = Urls.albums + '/$albumId' + Urls.photos;
    var url = Uri.https(Urls.baseUrl, path);
    return url;
  }
}
