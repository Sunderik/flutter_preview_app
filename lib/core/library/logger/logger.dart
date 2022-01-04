import 'package:logger/logger.dart';

/// Переопределения типа логера для вывода в консоль.
Logger logger = Logger(
  printer: PrettyPrinter(methodCount: 0, printTime: true),
);
