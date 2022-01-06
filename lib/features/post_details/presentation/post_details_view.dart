import 'package:azorin_test/features/post_details/presentation/post_details_bloc.dart';
import 'package:azorin_test/features/post_details/presentation/widgets/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:azorin_test/core/core.dart';

///
class PostDetailsView extends StatefulWidget {
  const PostDetailsView({Key? key}) : super(key: key);

  @override
  _PostDetailsViewState createState() => _PostDetailsViewState();
}

///
class _PostDetailsViewState extends State<PostDetailsView> {
  ///
  PostDetailsBloc get bloc => Provider.of<PostDetailsBloc>(context, listen: false);

  ///
  static const String _loadingError = 'Ошибка загрузки';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _getScaffold(
        body: StreamBuilder<ScreenStatusEnum?>(
            stream: bloc.postDetailsScreenStatusStream,
            initialData: ScreenStatusEnum.init,
            builder: (context, snapshot) {
              final screenStatus = snapshot.data;

              if (screenStatus == null) {
                return _getErrorScreenView();
              }

              switch (screenStatus) {
                case ScreenStatusEnum.init:
                  bloc.loadPostInfo();
                  return _getLoadingScreenView();
                case ScreenStatusEnum.loading:
                  return _getLoadingScreenView();
                case ScreenStatusEnum.wait:
                  final data = bloc.post;
                  if (data == null) {
                    return _getErrorScreenView();
                  }
                  return _getWaitScreenView(post: data);
                case ScreenStatusEnum.fail:
                default:
                  return _getErrorScreenView();
              }
            }),
      ),
    );
  }

  /// Возвращает Scaffold.
  ///
  /// [body] - поле body у виджета Scaffold.
  Widget _getScaffold({required Widget body}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пост'),
      ),
      body: body,
      floatingActionButton: StreamBuilder<ScreenStatusEnum?>(
          stream: bloc.postDetailsScreenStatusStream,
          initialData: ScreenStatusEnum.init,
          builder: (context, snapshot) {
            final screenStatus = snapshot.data;

            if (screenStatus == null) {
              return Container();
            }

            switch (screenStatus) {
              case ScreenStatusEnum.wait:
                return FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddCommentDialog(
                          email: bloc.userEmail ?? '',
                          onAddComment: (name, body, email) {
                            bloc.addComment(name, body, email);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    });
              case ScreenStatusEnum.fail:
              case ScreenStatusEnum.init:
              case ScreenStatusEnum.loading:
              default:
                return Container();
            }
          }),
    );
  }

  /// Возвращает окно загрузки.
  Widget _getLoadingScreenView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Container(height: 10.0),
          const Text('Загружаем комментарии'),
        ],
      ),
    );
  }

  /// Возвращает окно ошибки.
  Widget _getErrorScreenView() {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: const Center(child: Text(_loadingError)),
          )
        ],
      ),
    );
  }

  /// Возвращает основные виджеты.
  ///
  /// [post] - объект пользователя.
  Widget _getWaitScreenView({required Post post}) {
    return StreamBuilder<List<Comment>?>(
        stream: bloc.commentsStream,
        initialData: null,
        builder: (context, snapshot) {
          var comments = snapshot.data;
          if (comments == null) {
            bloc.loadPostComments();
          } else if (comments.isEmpty) {
            return const Center(
              child: Text('Комментарии отсутствуют.'),
            );
          } else if (comments.isNotEmpty) {
            return CommentsList(
              comments: comments,
            );
          }
          return Container();
        });
  }
}
