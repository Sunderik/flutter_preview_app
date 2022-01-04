import 'package:built_redux/built_redux.dart';

import 'app_route.dart';

part 'navigation_actions.g.dart';

abstract class NavigationActions extends ReduxActions {
  NavigationActions._();

  factory NavigationActions() = _$NavigationActions;

  ActionDispatcher<AppRoute> get routeTo;
}
