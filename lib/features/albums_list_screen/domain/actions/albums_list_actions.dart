import 'package:azorin_test/core/core.dart';
import 'package:built_redux/built_redux.dart';

part 'albums_list_actions.g.dart';
///
abstract class AlbumsListScreenActions extends ReduxActions {
  AlbumsListScreenActions._();

  factory AlbumsListScreenActions() => _$AlbumsListScreenActions();

  /// Определение статуса экрана окна.
  late ActionDispatcher<ScreenStatusEnum> setAlbumsListScreenStatus;
}
