import 'dart:async';

import 'package:azorin_test/app_starter.dart';
import 'package:azorin_test/injection.dart';
import 'package:azorin_test/test_app.dart';
import 'package:flutter/material.dart';

import 'core/library/logger/logger.dart';

/// Точка входа в приложение
Future<void> main() async {
  // Перехват зональных ошибок
  runZonedGuarded<Future<void>>(() async {
    // Обязательно перед FlutterError.onError
    WidgetsFlutterBinding.ensureInitialized();

    // Перехват ошибок, происходящих в рамках Flutter framework и их отправка
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      logger.e("Flutter Error", errorDetails.exception, errorDetails.stack);
    };

    await configureInjection(Env.prod);

    await startApp();

    runApp(const TestApp());
  }, (error, stackTrace) async {
    logger.e('Zoned Error', error, stackTrace);
  });
}
