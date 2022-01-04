import 'package:azorin_test/core/network/models/rest_bundle.dart';
import 'package:azorin_test/core/network/service/rest_service.dart';
import 'package:azorin_test/core/utilities/isolate_manager/isolate_executor.dart';
import 'package:azorin_test/core/utilities/isolate_manager/task.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class IsolateManagerMixin {
  void subscribe<I, O>(Stream input, Subject output, Function function) {
    input.listen((bundle) {
      if (!kIsWeb) {
        final task = Task<I, O>(bundle: bundle, function: function, timeout: bundle.timeout);
        IsolateExecutor().addTask<I, O>(task: task).listen(output.add).onError((err) {
          logger.e('onError $err');
          output.addError(err);
        });
      } else {
        dynamic _subFunc(dynamic bundle) {
          return function(bundle);
        }

        compute(_subFunc, bundle).then((value) => output.add(value)).catchError((err) {
          logger.e('onError $err');
          output.addError(err);
        });
      }
    });
  }

  void executeRestPostRequest(Subject input, Subject output, RestService service, Uri uri, Built request,
      Serializer serializer, Duration timeout,
      {String? key}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key, data: response?.body, serializer: serializer, timeout: timeout, status: response?.statusCode));
    }

    final requestFuture = service.post(uri, request).catchError((err) {
      output.addError(err);
    });

    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((err) {
      logger.e('requestFuture.catchError $err $uri $request');
      output.addError(err);
    });
  }

  void executeRestPostStringRequest(Subject input, Subject output, RestService service, Uri uri, String request,
      Serializer serializer, Duration? timeout,
      {String? key, Map<String, String>? headers}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key, data: response?.body, serializer: serializer, timeout: timeout, status: response?.statusCode));
    }

    final requestFuture = service.postStringRequest(uri, request, headers: headers).catchError((err) {
      output.addError(err);
    });
    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((err) {
      logger.e('requestFuture.catchError $err $uri $request');
      output.addError(err);
    });
  }

  void executeGetRestRequest(
      Subject input, Subject output, RestService service, Uri uri, Serializer serializer, Duration timeout,
      {String? key}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key,
          data: response?.body,
          bodyBytes: response?.bodyBytes,
          serializer: serializer,
          timeout: timeout,
          status: response?.statusCode));
    }

    final requestFuture = service.get(uri).catchError((err) {
      output.addError(err);
    });
    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((err) {
      logger.e('requestFuture.catchError $err $uri');
      output.addError(err);
    });
  }

  void executeRestGetStringRequest(
      Subject input, Subject output, RestService service, Uri uri, Serializer serializer, Duration? timeout,
      {String? key, Map<String, String>? headers}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key,
          data: response?.body,
          bodyBytes: response?.bodyBytes,
          serializer: serializer,
          timeout: timeout,
          status: response?.statusCode));
    }

    final requestFuture = service
        .getStringRequest(uri, queryParameters: null, deserializer: null, headers: headers)
        .catchError((Object err) {
      output.addError(err);
    });

    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((Object err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((Object err) {
      logger.e('requestFuture.catchError $err $uri');
      output.addError(err);
    });
  }

  void executeRestStringRequest(Subject input, Subject output, RestService service, Uri uri, String request,
      Serializer serializer, Duration timeout,
      {String? key}) {
    void _sinkData(response) {
      input.add(RestBundle(
          key: key,
          data: response?.body,
          bodyBytes: response?.bodyBytes,
          serializer: serializer,
          timeout: timeout,
          status: response?.statusCode));
    }

    final requestFuture = service.postStringRequest(uri, request).catchError((err) {
      output.addError(err);
    });
    if (timeout != null) {
      final start = DateTime.now().millisecondsSinceEpoch;
      logger.v('with timeout $timeout $start');
      requestFuture.timeout(timeout).catchError((err) {
        logger.v('timeout.catchError $err $timeout ms: ${DateTime.now().millisecondsSinceEpoch - start}');
        output.addError(err);
      });
    }

    requestFuture.then(_sinkData).catchError((err) {
      logger.e('requestFuture.catchError $err $uri $request');
      output.addError(err);
    });
  }
}
