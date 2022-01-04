import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/posts_list_screen/presentation/posts_list_screen_bloc.dart';
import 'package:azorin_test/features/posts_list_screen/presentation/widgets/posts_list_content.dart';

///
class PostsListScreenView extends StatefulWidget {
  const PostsListScreenView({Key? key}) : super(key: key);

  @override
  _PostsListScreenViewState createState() => _PostsListScreenViewState();
}

///
class _PostsListScreenViewState extends State<PostsListScreenView> {
  ///
  PostsListScreenBloc get bloc => Provider.of<PostsListScreenBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Посты'),
        ),
        body: StreamBuilder<ScreenStatusEnum>(
            stream: bloc.postsListScreenStatusController.stream,
            initialData: ScreenStatusEnum.init,
            builder: (context, snapshot) {
              final status = snapshot.data;
              return StreamBuilder<BuiltList<Post>?>(
                stream: bloc.postsController.stream,
                builder: (context, snapshot) {
                  final posts = bloc.posts;
                  switch (status) {
                    case ScreenStatusEnum.loading:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            Container(height: 10.0),
                            const Text('Загружаем посты пользователя'),
                          ],
                        ),
                      );
                    case ScreenStatusEnum.wait:
                      {
                        if (posts == null || posts.isEmpty) {
                          return Center(
                            child: Text(
                              'Постов нет',
                              style: TextStyle(color: Theme.of(context).backgroundColor),
                            ),
                          );
                        } else {
                          return const PostsListContent();
                        }
                      }
                    case ScreenStatusEnum.init:
                    default:
                      return Container();
                  }
                },
              );
            }),
      ),
    );
  }
}
