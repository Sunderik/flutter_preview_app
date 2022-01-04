import 'package:azorin_test/core/domain/domain.dart';
import 'package:azorin_test/core/library/transitions/transitions.dart';
import 'package:azorin_test/features/albums_list_screen/presentation/albums_list_screen.dart';
import 'package:azorin_test/features/navigation/data/navigation_type.dart';
import 'package:azorin_test/features/navigation/data/transition_type.dart';
import 'package:azorin_test/features/posts_list_screen/presentation/posts_list_screen.dart';
import 'package:azorin_test/features/user_details_screen/presentation/user_details_screen.dart';
import 'package:azorin_test/features/user_details_screen/presentation/widgets/map_view.dart';
import 'package:azorin_test/features/users_list_screen/presentation/users_list_screen.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter/material.dart' hide Action;

import '../../navigation.dart';
import '../app_route.dart';
import '../navigation_actions.dart';

MiddlewareBuilder<AppState, AppStateBuilder, AppActions> navigationMiddleware() {
  return MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()..add(NavigationActionsNames.routeTo, routeTo);
}

void routeTo(
    MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action<AppRoute> action) async {
  next(action);
  final payload = action.payload;
  final rootNavigator = api.state.navigationState.rootNavigatorKey!.currentState;
  dynamic materialPageRoute;

  materialPageRoute = _getMaterialPageRoute(api, payload);
  if (materialPageRoute != null && payload.route != Routes.pop) {
    final NavigationType navigationType = payload.navigationType ?? NavigationType.push;
    switch (navigationType) {
      case NavigationType.push:
        rootNavigator?.push(materialPageRoute);
        break;
      case NavigationType.pushReplacement:
        rootNavigator?.pushReplacement(materialPageRoute);
        break;
      case NavigationType.pushAndRemoveUntil:
        rootNavigator?.pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
        break;
    }
  }
}

/// Формирует окно на основе информации о переходе
dynamic _getMaterialPageRoute(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, AppRoute payload) {
  dynamic _materialPageRoute;

  RouteSettings _settings = RouteSettings(name: payload.route.name);

  late Widget _nextPage;

  switch (payload.route) {
    case Routes.usersList:
      _nextPage = const UsersListScreen();
      break;
    case Routes.userDetails:
      final int userId = (payload.bundle as Map<String, dynamic>)['userId']!;
      _nextPage = UserDetails(userId: userId);
      break;
    case Routes.postsList:
      final int userId = (payload.bundle as Map<String, dynamic>)['userId']!;
      _nextPage = PostsListScreen(userId: userId);
      break;
    case Routes.albumsList:
      final int userId = (payload.bundle as Map<String, dynamic>)['userId']!;
      _nextPage = AlbumsListScreen(userId: userId);
      break;
    case Routes.showMap:
      final Geolocation geolocation = (payload.bundle as Map<String, dynamic>)['geolocation']!;
      _nextPage = MapView(geolocation: geolocation);
      break;
    case Routes.pop:
      _materialPageRoute = MaterialPageRoute(
        settings: _settings,
        builder: (context) {
          return _nextPage;
        },
      );
      break;
    default:
      break;
  }
  // Без данного условия ошибка при _nextPage == null
  if (payload.route != Routes.pop) {
    switch (payload.transitionType) {
      case TransitionType.backSlide:
        {
          ///Пока лучше не использовать этот тип.
          _materialPageRoute = BackSlideRoute(settings: _settings, enterPage: _nextPage, exitPage: null);
          break;
        }
      case TransitionType.fade:
        {
          _materialPageRoute = FadeRoute(settings: _settings, page: _nextPage);
          break;
        }
      case TransitionType.rightSlide:
        {
          _materialPageRoute = RightSlideRoute(settings: _settings, page: _nextPage);
          break;
        }
      default:
        _materialPageRoute = MaterialPageRoute(
          settings: _settings,
          builder: (context) {
            return _nextPage;
          },
        );
        break;
    }
  }
  return _materialPageRoute;
}
