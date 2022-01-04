import 'package:flutter/material.dart';

/// Тип перехода.
///
/// Окрыть логически дочерний экран.
class RightSlideRoute extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;

  RightSlideRoute({required this.page, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
