import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/albums_list_screen/domain/albums_list_reducer.dart';
import 'package:azorin_test/features/post_details/domain/post_details_reducer.dart';
import 'package:azorin_test/features/posts_list_screen/domain/posts_list_reducer.dart';
import 'package:azorin_test/features/user_details_screen/domain/domain.dart';
import 'package:built_redux/built_redux.dart';


/// Создание списка всех обработчкиов десвтий в приложении.
final reducerBuilder = ReducerBuilder<AppState, AppStateBuilder>()
  ..combineNested(createAppStateReducer())
  ..combineNested(createUsersReducer())
  ..combineNested(createUserDetailsReducer())
  ..combineNested(createPostDetailsReducer())
  ..combineNested(createPostsListReducer())
  ..combineNested(createAlbumsListReducer());
/// Создание посдиски всех обработчкиов десвтий в приложении.
final reducers = reducerBuilder.build();
