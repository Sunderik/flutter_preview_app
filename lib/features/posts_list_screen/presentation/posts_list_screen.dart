import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'posts_list_screen_bloc.dart';
import 'posts_list_screen_view.dart';

///
class PostsListScreen extends StatelessWidget {
  final int userId;

  const PostsListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext ctx) => PostsListScreenBloc(userId)..init(),
      dispose: (BuildContext ctx, PostsListScreenBloc bloc) => bloc.dispose(),
      child: const PostsListScreenView(),
    );
  }
}
