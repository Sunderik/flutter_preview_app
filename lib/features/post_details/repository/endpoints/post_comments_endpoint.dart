import 'package:azorin_test/core/core.dart';

///
class PostCommentsEndpoint implements Endpoint {
  ///
  final int? postId;

  PostCommentsEndpoint(this.postId);

  @override
  Uri create() {
    String path = Urls.posts + '/$postId' + Urls.comments;
    var url = Uri.https(Urls.baseUrl, path);
    return url;
  }
}
