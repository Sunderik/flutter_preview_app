import 'package:azorin_test/features/users_list_screen/presentation/users_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:azorin_test/core/core.dart';

import 'app_starter.dart' as starter;

/// Корневой виджет прложения.
class TestApp extends StatefulWidget {
  /// Конструктор корневого виджета прложения.
  const TestApp({Key? key}) : super(key: key);

  @override
  _TestAppState createState() => _TestAppState();
}

/// Корневой стейт прложения.
class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return ReduxProvider(
      store: starter.store,
      child: StoreConnection<AppState, AppActions, AppTheme>(
        connect: (appState) => appState.appTheme,
        builder: (ctx, appTheme, actions) => MaterialApp(
            navigatorKey: starter.store?.state.navigationState.rootNavigatorKey,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru'),
            ],
            title: 'Test App',
            theme: appTheme == AppTheme.dark ? darkTheme(context) : lightTheme(context),
            home: const UsersListScreen()),
      ),
    );
  }
}
