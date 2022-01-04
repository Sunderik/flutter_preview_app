import 'package:injectable/injectable.dart';

/// Интерфейс конечной точки запроса.
abstract class Endpoint {
  ///Создание url запроса
  Uri create();
}

/// Фабрика адресов
abstract class UrlFactory {
  /// Создания обьекта конечной точки
  Uri createFor<T extends Endpoint>(T endpoint);
}

/// Реализация интерфейса [Endpoint]
@Injectable(as: UrlFactory)
class UrlAbstractFactory implements UrlFactory {
  @override
  Uri createFor<T extends Endpoint>(T endpoint) {
    return endpoint.create();
  }
}
