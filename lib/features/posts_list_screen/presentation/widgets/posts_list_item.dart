import 'package:azorin_test/core/core.dart';
import 'package:flutter/material.dart';

///
class PostsListItem extends StatelessWidget {
  /// Объект поста пользователя.
  final Post post;

  /// Действие по нажатию.
  final Function() onTap;

  const PostsListItem({Key? key, required this.post, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          post.title != null ? post.title! : '',
          style: const TextStyle(color: Color.fromRGBO(59, 59, 59, 1.0), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          post.body != null ? post.body! : '',
          style: const TextStyle(color: Color.fromRGBO(59, 59, 59, 1.0), fontWeight: FontWeight.w400, fontSize: 14),
        ),
        dense: true,
        onTap: onTap,
      ),
    );
  }
}
