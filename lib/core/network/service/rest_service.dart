import 'dart:convert';

import 'package:azorin_test/core/network/interceptor/auth_interceptor.dart';
import 'package:azorin_test/core/network/interceptor/interceptor.dart';
import 'package:azorin_test/core/network/models/network_serializers.dart';
import 'package:azorin_test/core/library/logger/logger.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

const _methodPost = 'POST';
const _methodGet = 'GET';

/// Интерфейс сервиса отправки запросов
abstract class RestService {
  /// Отправить базовый запрос на получение данных
  Future<RESP> get<RESP>(
    Uri path, {
    Map<String, dynamic> queryParameters,
  });

  /// Отправить запрос на получение данных в виде строки
  Future<RESP> getStringRequest<RESP>(
    Uri path, {
    Map<String, dynamic>? queryParameters,
    Serializer? deserializer,
    Map<String, String>? headers,
  });

  /// Отправить базовый запрос на запись данных
  Future<RESP> post<RESP>(Uri path, Built request, {Serializer? deserializer, Map<String, String>? headers});

  /// Отправить запрос на запись данных в виде строки
  Future<RESP> postStringRequest<RESP>(Uri url, String stringRequest,
      {Serializer? deserializer, Map<String, String>? headers});

  /// Использующиеся интерсепторы.
  Map<int, Interceptor> get interceptors;

  /// Изменение статуса логирования
  void setLoggingEnabled(bool isEnabled, {bool stripBody});

  /// Долбавить инетерсептор [interceptor] по ключу [order]
  void addInterceptor(int order, Interceptor interceptor);

  /// Удалить интерсептор [interceptor]
  void removeInterceptor(Interceptor interceptor);
}

/// Реализация сетевого сервиса отправки запросов [RestService]
@Injectable(as: RestService)
class RestServiceImpl implements RestService {
  RestServiceImpl(
    this.client,
  );

  /// Http клиент
  final Client client;

  /// Включение логиролвания запросов и ответов
  bool _isLoggingEnabled = true;

  /// Влючение в логирование тело ответа и запроса
  final bool _debugBody = false;

  @override
  Map<int, Interceptor> interceptors = {
    1: AuthInterceptor(),
  };

  @override
  void setLoggingEnabled(bool isEnabled, {bool? stripBody}) {
    _isLoggingEnabled = isEnabled;
  }

  @override
  void addInterceptor(int order, Interceptor interceptor) {
    interceptors.putIfAbsent(order, () => interceptor);
  }

  @override
  void removeInterceptor(Interceptor interceptor) {
    interceptors.removeWhere((key, value) => value == interceptor);
  }

  @override
  Future<RESP> postStringRequest<RESP>(Uri url, String stringRequest,
      {Serializer? deserializer, Map<String, String>? headers}) async {
    final request = Request(_methodPost, url)..body = stringRequest;

    _interceptRequest(request);

    headers?.forEach((key, update) {
      request.headers.update(key, (value) => update, ifAbsent: () => update);
    });

    if (_isLoggingEnabled) {
      _printRequestLog(_methodPost, request);
    }

    final response = await Response.fromStream(
      await client.send(request).catchError(
        (error) {
          logger.e(error);
          throw error;
        },
      ),
    );

    if (_isLoggingEnabled) {
      _printResponseLog(_methodPost, response);
    }

    if (deserializer != null) {
      return serializers.deserializeWith(deserializer, jsonDecode(response.body)) as RESP;
    } else {
      return response as RESP;
    }
  }

  @override
  Future<RESPONSE> post<RESPONSE>(Uri url, Built requestBody,
      {Serializer? deserializer, Map<String, String>? headers}) {
    final json = JsonCodec().encode(serializers.serialize(requestBody));
    return postStringRequest(url, json.toString(), deserializer: deserializer, headers: headers);
  }

  @override
  Future<RESP> get<RESP>(Uri path, {Map<String, dynamic>? queryParameters, Serializer? deserializer}) async {
    final request = Request(_methodGet, path);
    _interceptRequest(request);
    if (_isLoggingEnabled) {
      _printRequestLog(_methodGet, request);
    }
    final response = await Response.fromStream(
      await client.send(request).catchError(
        (error) {
          throw error;
        },
      ),
    );

    if (_isLoggingEnabled) {
      _printResponseLog(_methodGet, response);
    }

    if (deserializer != null) {
      return serializers.deserializeWith(
        deserializer,
        jsonDecode(response.body),
      ) as RESP;
    } else {
      return response as RESP;
    }
  }

  @override
  Future<RESP> getStringRequest<RESP>(
    Uri path, {
    Map<String, dynamic>? queryParameters,
    Serializer? deserializer,
    Map<String, String>? headers,
  }) async {
    final request = Request(_methodGet, path);

    _interceptRequest(request);

    headers?.forEach((key, update) {
      request.headers.update(key, (value) => update, ifAbsent: () => update);
    });

    if (_isLoggingEnabled) {
      _printRequestLog(_methodGet, request);
    }
    final response = await Response.fromStream(
      await client.send(request).catchError(
        (error, stackTrace) {
          logger.e('Error in getStringRequest', error, stackTrace);
          throw error;
        },
      ),
    );

    if (_isLoggingEnabled) {
      _printResponseLog(_methodGet, response);
    }

    if (deserializer != null) {
      return serializers.deserializeWith(
        deserializer,
        jsonDecode(response.body),
      ) as RESP;
    } else {
      return response as RESP;
    }
  }

  /// Подписание запроса.
  void _interceptRequest(request) {
    try {
      final sortedInterceptors = interceptors.keys.toList()..sort();
      sortedInterceptors.forEach((key) => interceptors[key]!.intercept(request));
    } catch (error) {
      logger.e('interceptor error: $error');
    }
  }

  /// Выввести лог ответа.
  void _printResponseLog(String method, Response response) {
    String logBody = '';
    logBody += '$method ${response.request!.url}';
    logBody += '\nstatus: ${response.statusCode}';
    logBody += '\ncontent length: ${response.contentLength}';
    if (_debugBody && response.body.isNotEmpty) {
      logBody += '\nbody: ${response.body}';
    }
    logger.v(logBody);
  }

  /// Вывести лог запроса.
  void _printRequestLog(String method, Request request) {
    String logBody = '';
    logBody += '$method ${request.url}';
    request.headers.forEach((key, value) => logBody += '\n$key: $value');
    if (_debugBody && request.body.isNotEmpty) {
      logBody += '\nbody: ${request.body}';
    }
    logger.v(logBody);
  }
}
