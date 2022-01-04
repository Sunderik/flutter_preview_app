import 'package:azorin_test/core/di/provider/store_provider.dart';
import 'package:azorin_test/injection.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

import 'interceptor.dart';

const contentTypeHeader = 'application/json';

///
class AuthInterceptor implements Interceptor {
  ///
  final StoreProvider _storeProvider = injector.get<StoreProvider>();

  @override
  BaseRequest intercept(BaseRequest request) {
    request.headers.update('content-type', (update) => contentTypeHeader, ifAbsent: () => contentTypeHeader);
    return request;
  }

  ///
  @override
  String toString() {
    return '$runtimeType';
  }
}
