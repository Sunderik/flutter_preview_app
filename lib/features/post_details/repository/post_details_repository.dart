import 'dart:convert';

import 'package:azorin_test/features/post_details/repository/endpoints/add_comment_endpoint.dart';
import 'package:azorin_test/features/post_details/repository/endpoints/post_comments_endpoint.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/core/network/models/rest_bundle.dart';
import 'package:azorin_test/core/network/service/rest_service.dart';
import 'package:azorin_test/core/utilities/isolate_manager/isolate_manager_mixin.dart';
import 'package:azorin_test/core/library/logger/logger.dart';

import 'models/_models.dart';

///
abstract class PostDetailsRepository {
  ///
  Stream<PostCommentsResponse> makePostCommentsRequest({required int postId, Duration timeout});

  ///
  Stream<AddCommentResponse> makeAddCommentRequest({required AddCommentRequest request, Duration timeout});
}

///
@Injectable(as: PostDetailsRepository)
class PostDetailsRepositoryImpl with IsolateManagerMixin implements PostDetailsRepository {
  late final RestService _restService;
  late final UrlFactory _urlFactory;

  PostDetailsRepositoryImpl(this._restService, this._urlFactory);

  @override
  Stream<PostCommentsResponse> makePostCommentsRequest(
      {required int postId, Duration timeout = const Duration(seconds: 20)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<PostCommentsResponse>();
    subscribe(inputSubject, outputSubject, postCommentsMapRestBundle);
    _makePostCommentsRequest(
      input: inputSubject,
      output: outputSubject,
      postId: postId,
      timeout: timeout,
    );

    return outputSubject.map((output) => output);
  }

  ///
  void _makePostCommentsRequest(
      {required BehaviorSubject<RestBundle> input,
      required BehaviorSubject<PostCommentsResponse> output,
      required int postId,
      required Duration timeout}) {
    final endpoint = PostCommentsEndpoint(postId);
    final url = _urlFactory.createFor<PostCommentsEndpoint>(endpoint);
    executeGetRestRequest(
      input,
      output,
      _restService,
      url,
      PostCommentsResponse.serializer,
      timeout,
    );
  }

  @override
  Stream<AddCommentResponse> makeAddCommentRequest(
      {required AddCommentRequest request, Duration timeout = const Duration(seconds: 20)}) {
    final inputSubject = BehaviorSubject<RestBundle>();
    final outputSubject = BehaviorSubject<AddCommentResponse>();
    subscribe(inputSubject, outputSubject, addCommentMapRestBundle);
    _makeAddCommentRequest(
      input: inputSubject,
      output: outputSubject,
      request: request,
      timeout: timeout,
    );

    return outputSubject.map((output) => output);
  }

  ///
  void _makeAddCommentRequest(
      {required BehaviorSubject<RestBundle> input,
      required BehaviorSubject<AddCommentResponse> output,
      required AddCommentRequest request,
      required Duration timeout}) {
    final endpoint = AddCommentEndpoint();
    final url = _urlFactory.createFor<AddCommentEndpoint>(endpoint);
    final requestString = request.toJson();
    executeRestPostStringRequest(
        input, output, _restService, url, requestString, AddCommentResponse.serializer, timeout);
  }
}

///
PostCommentsResponse postCommentsMapRestBundle(RestBundle bundle) {
  if (bundle.status != 200) {
    return PostCommentsResponse((builder) => builder
      ..httpCode = bundle.status
      ..message = bundle.data.toString());
  }
  try {
    final jsonDecoded = {"comments": jsonDecode(bundle.data ?? '')};
    PostCommentsResponse response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } catch (err) {
    logger.e('postCommentsMapRestBundle $err');
    return PostCommentsResponse((builder) => builder.httpCode = bundle.status);
  }
}

///
AddCommentResponse addCommentMapRestBundle(RestBundle bundle) {
  if (bundle.status != 201) {
    return AddCommentResponse((builder) => builder
      ..httpCode = bundle.status
      ..message = bundle.data.toString());
  }
  try {
    final jsonDecoded = {"comment": jsonDecode(bundle.data ?? '')};
    AddCommentResponse response = serializers.deserializeWith(bundle.serializer!, jsonDecoded);
    return response.rebuild((builder) => builder.httpCode = bundle.status);
  } catch (err) {
    logger.e('addCommentMapRestBundle $err');
    return AddCommentResponse((builder) => builder.httpCode = bundle.status);
  }
}
