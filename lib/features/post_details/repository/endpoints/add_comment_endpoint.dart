import 'package:azorin_test/core/core.dart';

///
class AddCommentEndpoint implements Endpoint {
  AddCommentEndpoint();

  @override
  Uri create() {
    String path = Urls.posts;
    var url = Uri.https(Urls.baseUrl, path);
    return url;
  }
}
