import 'package:azorin_test/core/core.dart';
import 'package:built_redux/built_redux.dart';

part 'posts_list_actions.g.dart';
///
abstract class PostsListScreenActions extends ReduxActions {
  PostsListScreenActions._();

  factory PostsListScreenActions() => _$PostsListScreenActions();

  /// Определение статуса экрана окна.
  late ActionDispatcher<ScreenStatusEnum> setPostsListScreenStatus;
}
