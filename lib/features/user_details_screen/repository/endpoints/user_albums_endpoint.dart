import 'package:azorin_test/core/core.dart';
///
class UserAlbumsEndpoint implements Endpoint {
  ///
  final int? userId;

  UserAlbumsEndpoint(this.userId);

  @override
  Uri create() {
    String path = Urls.users + '/$userId' + Urls.albums;
    var url = Uri.https(Urls.baseUrl, path);
    return url;
  }
}
