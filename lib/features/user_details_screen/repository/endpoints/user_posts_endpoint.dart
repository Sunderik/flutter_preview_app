import 'package:azorin_test/core/core.dart';
///
class UserPostsEndpoint implements Endpoint {
  ///
  final int? userId;

  UserPostsEndpoint(this.userId);

  @override
  Uri create() {
    String path = Urls.users + '/$userId' + Urls.posts;
    var url = Uri.https(Urls.baseUrl, path);
    return url;
  }
}
