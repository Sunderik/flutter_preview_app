import 'package:built_redux/built_redux.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/user_details_screen/repository/models/_models.dart';

part 'user_details_actions.g.dart';

///
abstract class UserDetailsActions extends ReduxActions {
  UserDetailsActions._();

  ///
  factory UserDetailsActions() => _$UserDetailsActions();

  /// Action на запись выбранного пользователя в стейт окна
  late ActionDispatcher<User> setUserDetails;

  /// Action запроса на получение последних трех постов пользователя
  late ActionDispatcher<UserPostsRequest> userPostsRequest;

  /// Action ответа на запрос получение последних трех постов пользователя
  late ActionDispatcher<UserPostsResponse> setUserPostsResponse;

  /// Action запроса на получение последних трех альбомов пользователя
  late ActionDispatcher<UserAlbumsRequest> userAlbumsRequest;

  /// Action ответа на запрос получение последних трех альбомов пользователя
  late ActionDispatcher<UserAlbumsResponse> setUserAlbumsResponse;

  /// Action определения статуса экрана в [UserDetailsState.screenStatus].
  late ActionDispatcher<ScreenStatusEnum> setUserDetailsScreenStatus;

  ///
  late ActionDispatcher<void> clearUserDetails;
}
