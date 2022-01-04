import 'package:azorin_test/core/core.dart';
///
class UsersListEndpoint implements Endpoint {
  UsersListEndpoint();

  @override
  Uri create() {
    return Uri.https(Urls.baseUrl, Urls.users);
  }
}
