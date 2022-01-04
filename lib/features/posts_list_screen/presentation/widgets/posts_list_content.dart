import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:azorin_test/core/core.dart';
import 'package:azorin_test/features/posts_list_screen/presentation/posts_list_screen_bloc.dart';
import 'package:azorin_test/features/posts_list_screen/presentation/widgets/posts_list_item.dart';
///
class PostsListContent extends StatefulWidget {
  const PostsListContent({Key? key}) : super(key: key);

  @override
  _PostsListContentState createState() => _PostsListContentState();
}
///
class _PostsListContentState extends State<PostsListContent> {
  ///
  PostsListScreenBloc get bloc => Provider.of<PostsListScreenBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuiltList<Post>>(
        stream: bloc.postsController.stream,
        builder: (context, snapshot) {
          final _posts = bloc.posts;
          return ListView.builder(
              itemCount: _posts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return PostsListItem(post: _posts![index], onTap: () => {bloc.openPostInfo(_posts[index])});
              });
        });
  }
}
