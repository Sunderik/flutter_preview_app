import 'package:azorin_test/core/domain/models/post.dart';
import 'package:azorin_test/features/user_details_screen/presentation/user_details_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
class PostPreviewList extends StatelessWidget {
  const PostPreviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsBloc bloc = Provider.of<UserDetailsBloc>(context, listen: false);

    return StreamBuilder<List<Post>?>(
        stream: bloc.postsStream,
        initialData: null,
        builder: (context, snapshot) {
          var posts = snapshot.data;
          if (posts == null) {
            bloc.loadUserPosts();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (posts.isEmpty) {
            return const Center(
              child: Text('Посты отсутствуют.'),
            );
          } else if (posts.isNotEmpty) {
            posts = posts.getRange(0, 3).toList();
            return Card(
              child: Column(
                children: [
                  _getCardHeader(bloc),
                  const Divider(indent: 8, endIndent: 8),
                  _getCardContent(posts),
                ],
              ),
            );
          }
          return Container();
        });
  }

  ///
  Widget _getCardHeader(UserDetailsBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Posts',
            style: TextStyle(fontSize: 16),
          ),
          GestureDetector(
            onTap: () => bloc.openPostsList(),
            child: const Chip(
              label: Text('ALL'),
              labelStyle: TextStyle(fontSize: 12),
              useDeleteButtonTooltip: false,
            ),
          ),
        ],
      ),
    );
  }

  ///
  Widget _getCardContent(List<Post> posts) {
    List<Widget> widgets = posts.map((post) {
      return Builder(
        builder: (BuildContext context) {
          return ListTile(
            onTap: () => {},
            title: Text(post.title!),
            subtitle: Text(
              post.body!,
              maxLines: 1,
            ),
          );
        },
      );
    }).toList();
    return CarouselSlider(
      options: CarouselOptions(height: 100.0, enableInfiniteScroll: false),
      items: widgets,
    );
  }
}
