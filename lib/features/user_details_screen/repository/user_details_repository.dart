import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/network/models/rest_bundle.dart';
import 'package:azorin_test/core/network/service/rest_service.dart';
import 'package:azorin_test/core/utilities/isolate_manager/isolate_manager_mixin.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:azorin_test/features/user_details_screen/repository/models/_models.dart';
import 'package:azorin_test/features/user_details_screen/repository/endpoints/endpoints.dart';

import 'models/_models.dart';

///
abstract class UserDetailsRepository {
  ///
  Stream<UserPostsResponse> makeUserPostsRequest({required int userId, Duration timeout});

  ///
  Stream<UserAlbumsResponse> makeUserAlbumsRequest({required int userId, Duration timeout});
}

///
@Injectable(as: UserDetailsRepository)
class UserDetailsRepositoryImpl with IsolateManagerMixin implements UserDetailsRepository {
  late final RestService _restService;
  late final UrlFactory _urlFactory;

  UserDetailsRepositoryImpl(this._restService, this._urlFactory);

  @override
  Stream<UserPostsResponse> makeUserPostsRequest(
      {required int userId, Duration timeout = const Duration(seconds: 20)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<UserPostsResponse>();
    subscribe(inputSubject, outputSubject, userPostsMapRestBundle);
    _makeUserPostsRequest(
      input: inputSubject,
      output: outputSubject,
      userId: userId,
      timeout: timeout,
    );

    return outputSubject.map((output) => output);
  }

  ///
  void _makeUserPostsRequest(
      {required BehaviorSubject<RestBundle> input,
      required BehaviorSubject<UserPostsResponse> output,
      required int userId,
      required Duration timeout}) {
    final endpoint = UserPostsEndpoint(userId);
    final url = _urlFactory.createFor<UserPostsEndpoint>(endpoint);
    executeGetRestRequest(
      input,
      output,
      _restService,
      url,
      UserPostsResponse.serializer,
      timeout,
    );
  }

  @override
  Stream<UserAlbumsResponse> makeUserAlbumsRequest(
      {required int userId, Duration timeout = const Duration(seconds: 20)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<UserAlbumsResponse>();
    subscribe(inputSubject, outputSubject, userAlbumsMapRestBundle);
    _makeUserAlbumsRequest(
      input: inputSubject,
      output: outputSubject,
      userId: userId,
      timeout: timeout,
    );

    return outputSubject.map((output) => output);
  }

  ///
  void _makeUserAlbumsRequest(
      {required BehaviorSubject<RestBundle> input,
      required BehaviorSubject<UserAlbumsResponse> output,
      required int userId,
      required Duration timeout}) {
    final endpoint = UserAlbumsEndpoint(userId);
    final url = _urlFactory.createFor<UserAlbumsEndpoint>(endpoint);

    executeGetRestRequest(input, output, _restService, url, UserAlbumsResponse.serializer, timeout);
  }
}

///
UserPostsResponse userPostsMapRestBundle(RestBundle bundle) {
  if (bundle.status != 200) {
    return UserPostsResponse((builder) => builder
      ..httpCode = bundle.status
      ..message = bundle.data.toString());
  }
  try {
    final jsonDecoded = {"posts": jsonDecode(bundle.data ?? '')};
    UserPostsResponse response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } catch (err) {
    logger.e('userPostsMapRestBundle $err');
    return UserPostsResponse((builder) => builder.httpCode = bundle.status);
  }
}

///
UserAlbumsResponse userAlbumsMapRestBundle(RestBundle bundle) {
  if (bundle.status != 200) {
    return UserAlbumsResponse((builder) => builder
      ..httpCode = bundle.status
      ..message = bundle.data.toString());
  }
  try {
    final jsonDecoded = {"albums": jsonDecode(bundle.data ?? '')};
    UserAlbumsResponse response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } catch (err) {
    logger.e('userAlbumsMapRestBundle $err');
    return UserAlbumsResponse((builder) => builder.httpCode = bundle.status);
  }
}
